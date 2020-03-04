class AddDiscardedAtToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :discarded_at, :datetime
    add_index :records, :discarded_at
  end
end
