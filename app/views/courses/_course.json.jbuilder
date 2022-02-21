json.extract! course, :id, :name, :description, :user_id, :instructorName, :weekdayone, :weekdaytwo, :starttime, :endtime, :coursecode, :capacity, :waitlistcapacity, :status, :room, :created_at, :updated_at
json.url course_url(course, format: :json)
