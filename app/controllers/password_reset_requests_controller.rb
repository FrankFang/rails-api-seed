class PasswordResetRequestsController < ApplicationController
  def create
    password_reset_request = PasswordResetRequest.create(params.permit(:email))
    render_resource password_reset_request
  end
end
