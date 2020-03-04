class SessionsController < ApplicationController
  def create
    s = Session.new(params.permit(:email, :password))
    if s.valid?
      self.current_user = s.user
      render json: {resource: s.user}
    else
      render json: {errors: s.errors}
    end
  end

  def destroy
    session.delete :current_user_id
    render json: {current_user_id: session[:current_user_id]}
  end
end
