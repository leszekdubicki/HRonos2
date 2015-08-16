class Admins::SessionsController < Devise::SessionsController
 #before_filter :configure_sign_in_params, only: [:create, :new]
 before_filter :configure_sign_in_params

  # GET /resource/sign_in
   def new
     super
   end

  # POST /resource/sign_in
   def create
     super
   end

  # DELETE /resource/sign_out
   def destroy
     super
   end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     #devise_parameter_sanitizer.for(:sign_in) << :employee
     #devise_parameter_sanitizer.for(:sign_up) << :employee
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, employee_atributes: [:first_name, :last_namem]) }
   end
end
