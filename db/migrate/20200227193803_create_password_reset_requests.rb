class CreatePasswordResetRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :password_reset_requests do |t|
      t.string :email, limit: 100, index: true
      t.string :code, limit: 256, index: true

      t.timestamps
    end
  end
end
