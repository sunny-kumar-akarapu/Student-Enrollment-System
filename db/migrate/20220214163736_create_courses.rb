class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :instructorName
      t.string :weekdayone
      t.string :weekdaytwo
      t.time :starttime
      t.time :endtime
      t.string :coursecode
      t.integer :capacity
      t.integer :waitlistcapacity
      t.string :status
      t.string :room

      t.timestamps
    end
    add_index :courses, :user_id
  end
end
