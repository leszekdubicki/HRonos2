class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :employee_attributes
  has_one :employee
  devise :database_authenticatable, #commented out to allow creating users while being signed in (as manager):registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 4..128 #password length changed for the user model only
  accepts_nested_attributes_for :employee
  def full_name
    #returns string to be displayed when showing or editing the record (instead of only email)
    full_name = email
    if employee
        full_name = full_name << " (" << employee.full_name << ")"
    end
    return full_name
  end
  #method for checking if current user is manager
  def is_manager?
    if employee
      if employee.level == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
