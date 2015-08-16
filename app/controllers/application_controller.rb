class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :checkaccounts!
  #helper_method :user_signed_in?
  #helper_method :admin_signed_in?
  #helper_method :current_user
  private
  def checkaccounts!
        checkadmin = true
        if checkadmin
          puts "checking if base admin account exists... (remember to turn off if running rake after changing db setup)"
          @admin = Admin.where(email: "leszek.dubicki@student.ncirl.ie").first
          if not @admin
            puts "adding base admin account"
            Admin.create!({:email => "leszek.dubicki@student.ncirl.ie", :password => "admin123", :password_confirmation => "admin123" })
          end
        end
  end
end
