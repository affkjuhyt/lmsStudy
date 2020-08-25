class AddDiscardedAtToRates < ActiveRecord::Migration[6.0]
  def change
    add_column :rates, :discarded_at, :datetime
    add_index :rates, :discarded_at
  end
end
