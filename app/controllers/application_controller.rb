class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #helper_method :user_signed_in?
  #helper_method :admin_signed_in?
  #helper_method :current_user
end
