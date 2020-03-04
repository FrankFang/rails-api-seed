# == Schema Information
#
# Table name: password_reset_requests
#
#  id         :bigint           not null, primary key
#  code       :string(256)
#  email      :string(100)
#  used_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_password_reset_requests_on_code   (code)
#  index_password_reset_requests_on_email  (email)
#
class PasswordResetRequest < ApplicationRecord
  has_secure_token :code
  validates_presence_of :email
  validate :find_user_by_email
  attr_reader :user
  after_create do
    PasswordResetRequestMailer.with(password_reset_request: self).after_request.deliver_later
  end

  private

  def find_user_by_email
    @user = User.find_by_email email
    if user.nil?
      errors.add :email, :not_found
    end
  end
end
