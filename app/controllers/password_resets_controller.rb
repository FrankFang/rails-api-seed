class PasswordResetsController < ApplicationController
  def create
    password_reset = PasswordReset.new(create_params)
    render_resource password_reset
  end

  private

  def create_params
    params.permit(:code, :password, :password_confirmation)
  end
end
