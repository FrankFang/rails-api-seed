class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from CustomError::MustSignIn, with: :unauthorized
  rescue_from CustomError::Forbidden, with: :forbidden

  def render_resource(to_validate, errors: nil, resource: nil, as_json: nil)
    if to_validate.valid?
      render json: {resource: (resource || to_validate).as_json(as_json)}, status: :ok
    else
      render json: {errors: errors || resource&.errors || to_validate.errors}, status: :unprocessable_entity
    end
  end

  def render_resources(resources, page: params[:page], order: params[:order], as_json: nil)
    resources = resources.order(order).page(page)
    p resources.to_sql
    render json: {resources: resources.as_json(as_json), pagination: {
      current_page: resources.current_page,
      per_page: resources.current_per_page,
      next_page: resources.next_page,
      prev_page: resources.prev_page,
      total_pages_count: resources.total_pages,
      total_count: resources.total_count
    }}
  end

  def current_user
    @current_user ||= User.find session[:current_user_id] rescue nil
  end

  def current_user=(user_or_user_id)
    session[:current_user_id] = (user_or_user_id.is_a? User) ? user_or_user_id.id : user_or_user_id
  end

  def must_sign_in
    if current_user.nil?
      raise CustomError::MustSignIn
    end
  end

  private

  def unauthorized
    head :unauthorized
  end

  def forbidden
    head :forbidden
  end
end
