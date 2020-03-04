class AddUsedAtForPasswordResetRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :password_reset_requests, :used_at, :datetime
  end
end
