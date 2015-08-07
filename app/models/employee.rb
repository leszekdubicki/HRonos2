class Employee < ActiveRecord::Base
  belongs_to :user
  has_many :vacations
  accepts_nested_attributes_for :vacations
end
