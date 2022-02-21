class User < ApplicationRecord
  rolify
  has_secure_password
  validates_uniqueness_of :email, format: { with: /(\A([a-z]\s)\<([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
  validates :name, presence: true
  validates :department, presence: true

  has_many :courses
  has_many :enrollments

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:Student) if self.roles.blank?
  end

end
