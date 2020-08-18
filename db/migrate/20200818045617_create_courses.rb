class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :course_title, null: false, limit: Settings.course.title
      t.string :course_overview, null: false, limit: Settings.course.overvuew
      t.text :course_description, null: false, limit: Settings.course.description
      t.string :course_image
      t.integer :total_rate_count
      t.integer :total_register_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
