class PasswordReset
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  attr_accessor :code, :password, :password_confirmation
  attr_reader :request
  validates_presence_of :code, :password, :password_confirmation
  validate :find_request_by_code
  validate :do_reset, if: :request

  def do_reset
    user = User.find_by_email @request.email
    return errors.add :code, :not_found if user.nil?
    unless user.update(password: password, password_confirmation: password_confirmation)
      errors.merge! user.errors
    end
  end

  private

  def find_request_by_code
    @request = PasswordResetRequest.find_by_code code
    if request.nil?
      errors.add :code, :not_found
    end
  end

end
