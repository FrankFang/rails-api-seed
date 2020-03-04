# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    user = User.new email: '1@example.com', name: '高圆圆'
    UserMailer.with(user: user).welcome_email
  end
end
