class Session
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :email, :password, :user

  validates_presence_of :email, :password
  validate :match_email_and_password

  private

  def match_email_and_password
    @user = User.find_by_email(email)
    if user.nil?
      errors.add :phone, :not_found
    elsif not user.authenticate(password)
      errors.add :password, :mismatched
    end
  end
end
