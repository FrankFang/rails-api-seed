class PasswordResetRequestMailer < ApplicationMailer

  def after_request
    @password_reset_request = params[:password_reset_request]
    @code = @password_reset_request.code
    mail(to: @password_reset_request.email, subject: '重置密码申请')
  end
end
