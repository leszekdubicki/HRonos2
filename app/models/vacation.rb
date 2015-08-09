class Vacation < ActiveRecord::Base
  belongs_to :employee
  def state_string
     if state == 0 or state == nil
        return "Waiting for approval"
    elsif state == 1
        return "Approved"
    elsif state == 2
        return "Declined"
    end
  end
end
