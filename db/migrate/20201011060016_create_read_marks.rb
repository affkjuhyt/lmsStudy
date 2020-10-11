class CreateReadMarks < ActiveRecord::Migration[6.0]
  def change
    create_table :read_marks do |t|
      t.string :readable_type
      t.integer :readable_id
      t.string :reader_type
      t.integer :reader_id

      t.timestamps
    end
  end
end
