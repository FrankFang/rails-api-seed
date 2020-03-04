class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.integer :amount
      t.string :notes
      t.integer :category, limit: 2, null: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
