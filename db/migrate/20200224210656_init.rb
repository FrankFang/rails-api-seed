class Init < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :phone
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    create_table :password_reset_requests do |t|
      t.string :email, limit: 100, index: true
      t.string :code, limit: 256, index: true
      t.datetime :used_at

      t.timestamps
    end
  end
end
