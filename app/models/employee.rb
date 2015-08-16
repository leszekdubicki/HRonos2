class Employee < ActiveRecord::Base
  belongs_to :user
  has_many :vacations
  accepts_nested_attributes_for :vacations
  #self-reference according to http://stackoverflow.com/questions/25134198/ruby-on-rails-access-model-data-within-another-model
  belongs_to :manager, :class_name => 'Employee'
  has_many :subordinates, :class_name => 'Employee', :foreign_key => 'manager_id'
  accepts_nested_attributes_for :subordinates
  accepts_nested_attributes_for :manager
  def full_name
      full_name = ""
      if first_name
          full_name = full_name << first_name
      end
      if last_name
          full_name = full_name << " " << last_name
      end
      return full_name
  end
end
