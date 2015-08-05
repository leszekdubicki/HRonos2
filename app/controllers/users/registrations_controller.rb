class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
 before_filter :configure_sign_in_params

  # GET /resource/sign_up
   def new
     super
     #self.build_employee
   end

  # POST /resource
   def create
    #User.save!
    super
    if resource.save
        @employee = Employee.new()
        @employee.user_id = resource.id
        @employee.save
        
    end
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     #devise_parameter_sanitizer.for(:sign_in) << :employee
     devise_parameter_sanitizer.for(:sign_up) << :employee
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, employee_atributes: [:first_name, :last_namem]) }
   end
end
