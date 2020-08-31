class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.integer :choice, null: false

      t.timestamps
    end
  end
end
