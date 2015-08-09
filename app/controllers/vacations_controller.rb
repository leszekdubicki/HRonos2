class VacationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_vacation, only: [:show, :edit, :update, :destroy]

  # GET /vacations
  # GET /vacations.json
  def index
    #display only vacations for currently logged in user:
    @employee = Employee.where(user_id: current_user.id)
    if @employee[0]
        @vacations = Vacation.where(employee_id: @employee[0].id)
    else
        @vacations = nil
    end
    #listing vacation requests waiting for approval in case logged in user is a manager:
    @manager = false
    if Employee.where(user_id: current_user.id)[0].level == 1
        @manager = true
        #find all vacations where employee's manager is current user:
    end

  # GET /vacations/1
  # GET /vacations/1.json
  def show
  end

  # GET /vacations/new
  def new
    @vacation = Vacation.new
  end

  # GET /vacations/1/edit
  def edit
  end

  # POST /vacations
  # POST /vacations.json
  def create
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacation_params
      params.require(:vacation).permit(:employee_id, :start_date, :end_date, :employee_comments, :manager_comments, :state)
    end
end
