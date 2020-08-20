class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false, limit: Settings.course.title
      t.string :overview, null: false, limit: Settings.course.overvuew
      t.text :description, null: false, limit: Settings.course.description
      t.string :image
      t.integer :total_rate_count
      t.integer :total_register_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
