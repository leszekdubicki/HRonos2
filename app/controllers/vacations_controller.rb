class VacationsController < ApplicationController
  #include Devise::Controllers::Helpers
  #before_filter :authenticate_user!
  #verify what type of user is accessing information :w
  before_action :set_vacation, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  #before_filter :ensure_priviliged!

  # GET /vacations
  # GET /vacations.json
  def index
    check_who_logged_in!
    #display only vacations for currently logged in user:
    @employee = Employee.where(user_id: current_user.id)[0]
    if @employee
        @vacations = Vacation.where(employee_id: @employee.id)
    else
        @vacations = nil
    end
    #listing vacation requests waiting for approval in case logged in user is a manager:
    @manager = false
    #if Employee.where(user_id: current_user.id)[0].level == 1
    #if @employee.level == 1
    if @is_manager
        @manager = true
        #find all vacations where employee's manager is current user:
        @subordinates = @employee.subordinates
        #find vacations of all subordinates:
        @subvacations = []
        index = 0 #index of an array to set
        @subordinates.each do |subordinate|
            vac = Vacation.where(employee_id: subordinate.id)
            if vac
                @subvacations[index] = vac
                index += 1
            end
            vac = nil
        end
    end
  end
  # GET /vacations/1
  # GET /vacations/1.json
  def show
    @employee = Employee.where(user_id: current_user.id)[0]
  end

  # GET /vacations/new
  def new
    @employee = Employee.where(user_id: current_user.id)[0]
    @vacation = Vacation.new
  end

  # GET /vacations/1/edit
  def edit
    check_who_logged_in!
    @employee = Employee.where(user_id: current_user.id)[0]
    if not @vacation.state == 0
      redirect_to @vacation, notice: 'You cannot edit once vacation was processed by your manager.'
    end
  end

  # POST /vacations
  # POST /vacations.json
  def create
    check_who_logged_in!
    @vacation = Vacation.new(vacation_params)
    @employee = Employee.where(user_id: current_user.id)
    @vacation.employee_id = @employee[0].id
    @vacation.state = 0

    respond_to do |format|
      if @vacation.save
        format.html { redirect_to @vacation, notice: 'Vacation request was successfully created.' }
        format.json { render :show, status: :created, location: @vacation }
      else
        format.html { render :new }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacations/1
  # PATCH/PUT /vacations/1.json
  def update
    check_who_logged_in!
    respond_to do |format|
      if @vacation.update(vacation_params)
        format.html { redirect_to @vacation, notice: 'Vacation was successfully updated.' }
        format.json { render :show, status: :ok, location: @vacation }
      else
        format.html { render :edit }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacations/1
  # DELETE /vacations/1.json
  def destroy
    check_who_logged_in!
    @vacation.destroy
    respond_to do |format|
      format.html { redirect_to vacations_url, notice: 'Vacation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacation
      @vacation = Vacation.find(params[:id])
      #set @vacation to nil if user is not allowed to see it:
      if not admin_signed_in? and not current_user.is_manager? and not current_user.employee.id == @vacation.employee_id
       @vacation = nil 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacation_params
      #status can be only updated by managers and admins
      if admin_signed_in? or current_user.is_manager?
        params.require(:vacation).permit(:employee_id, :start_date, :end_date, :employee_comments, :manager_comments, :state)
      else
        params.require(:vacation).permit(:employee_id, :start_date, :end_date, :employee_comments)
      end
    end
    def ensure_priviliged!
      if not admin_signed_in? and current_user and not current_user.is_manager? 
        authenticate_admin!
      elsif not user_signed_in?
        authenticate_admin!
        #return false
      end
    end
    def check_who_logged_in!
      #variables showing who is signed in to pass to the view
      #if not current_user
      #    before_filter :authenticate_user!
      #    #at least user has to be signed in
      #end
      @is_user = false 
      @is_manager = false 
      @is_admin = false 
      @is_priviliged = false
      
      if user_signed_in? and current_user.employee
        @is_user = true
      end
      if current_user and current_user.is_manager?
          @is_priviliged = true
          @is_manager = true
      end
      if admin_signed_in?
          @is_priviliged = true
          @is_admin = false
      end  
    end
end
