class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.date :course_day
      t.string :course_content
      t.datetime :course_time
      t.string :course_level

      t.timestamps
    end
  end
end
