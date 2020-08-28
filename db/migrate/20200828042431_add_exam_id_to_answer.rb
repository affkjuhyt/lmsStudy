class AddExamIdToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_reference :answers, :exam, index: true
  end
end
