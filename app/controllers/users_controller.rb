class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_filter :configure_sign_in_params
  #only admin can manage users
  #before_filter :user_params
  #before_filter :authenticate_admin!
  before_filter :check_manager_logged_in!

  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params.permit(:email, :password, :password_confirmation))
    #@user.update_attributes(params[:user]permit[:email])
    respond_to do |format|
      if @user.save
        #create an empty employee record together with user
        @employee = Employee.new()
        @employee.user_id = @user.id
        @employee.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params.permit(:email, :password, :password_confirmation)) #fixed to avoid ForbiddenAttributesError
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
    #method to check if either manager or user is signed in
    def check_manager_logged_in!
      #variable is_priviliged to pass to the view
      @is_priviliged = true
      if !admin_signed_in?
        if current_user and !current_user.is_manager?
            #require admin authentication in case this is not manager
            #turned_off#authenticate_admin!
            @is_priviliged = false
        elsif not current_user
            @is_priviliged = false
        end  
      end
    end

   #def configure_sign_in_params
     #devise_parameter_sanitizer.for(:sign_in) << :employee
     #devise_parameter_sanitizer.for(:sign_up) << :employee
     #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, employee_atributes: [:first_name, :last_namem]) }
   #end
end
