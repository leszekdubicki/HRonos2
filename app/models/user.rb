class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :employee_attributes
  has_one :employee
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  accepts_nested_attributes_for :employee
  def full_name
    #returns string to be displayed when showing or editing the record (instead of only email)
    full_name = email
    if employee
        full_name = full_name << " (" << employee.full_name << ")"
    end
    return full_name
  end
end
