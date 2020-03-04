class PasswordResetRequestMailerPreview < ActionMailer::Preview
  def after_request
    prr = PasswordResetRequest.new email: '1@example.com', code: '123456'
    PasswordResetRequestMailer.with(password_reset_request: prr).after_request
  end
end
