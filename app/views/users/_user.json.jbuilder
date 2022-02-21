json.extract! user, :id, :email, :name, :department, :number, :dob, :major, :created_at, :updated_at
json.url user_url(user, format: :json)
