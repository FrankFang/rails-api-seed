class ChangeUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :phone
    add_column :users, :email, :string, limit: 100
    add_column :users, :password_digest, :string
  end
end
