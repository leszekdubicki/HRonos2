json.array!(@vacations) do |vacation|
  json.extract! vacation, :id, :employee_id, :start_date, :end_date, :employee_comments, :manager_comments, :state
  json.url vacation_url(vacation, format: :json)
end
