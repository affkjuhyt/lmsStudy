class CreateAnwsers < ActiveRecord::Migration[6.0]
  def change
    create_table :anwsers do |t|
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :anwser_choice, null: false

      t.timestamps
    end
  end
end
