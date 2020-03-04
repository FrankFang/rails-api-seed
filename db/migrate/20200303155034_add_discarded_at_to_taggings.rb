class AddDiscardedAtToTaggings < ActiveRecord::Migration[6.0]
  def change
    add_column :taggings, :discarded_at, :datetime
    add_index :taggings, :discarded_at
  end
end
