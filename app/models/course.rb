class Course < ApplicationRecord
    belongs_to :user
    has_many :enrollments
    validates :name, presence: true
    validates :description, presence: true
    validates :instructorName, presence: true
    validates :starttime,presence: true
    validates :endtime ,presence: true
    validate :endtime_is_after_starttime
    validates :weekdayone ,presence: true
    validate :check_weekdayone_and_weekdaytwo

    def check_weekdayone_and_weekdaytwo
    errors.add(:weekdaytwo, "can't be the same as weekdayone") if weekdayone == weekdaytwo
    end
    
    validates :coursecode,uniqueness: true,format: { with: /[A-Z]{3}[0-9]{3}/,
    message: "course code is not according to the format" }
    validates :capacity,presence: true
    validates :waitlistcapacity,presence: true
    validates :status,presence: true
    validates :room,presence: true

    private
    def endtime_is_after_starttime
        return if endtime.blank? || starttime.blank?
        if endtime < starttime
            errors.add(:endtime, "cannot be before the start time ")
        end
    end
end
