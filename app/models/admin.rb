class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #I've removed ', :registerable' from below declaratrions:
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
