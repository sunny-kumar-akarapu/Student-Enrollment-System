json.extract! enrollment, :id, :studentid, :courseid, :enrollmentstatus, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
