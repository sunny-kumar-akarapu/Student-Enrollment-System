class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.integer :studentid
      t.integer :courseid
      t.string :enrollmentstatus

      t.timestamps
    end
  end
end
