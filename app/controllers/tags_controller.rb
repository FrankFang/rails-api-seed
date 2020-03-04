class TagsController < ApplicationController
  before_action :must_sign_in

  def index
    @tags = Tag.where user_id: current_user.id
    render_resources @tags
  end

  def show
    tag = Tag.find params[:id]
    render_resource tag
  end

  def create
    if Tag.exists? create_params
      head :conflict
    else
      tag = Tag.create create_params.merge user: current_user
      render_resource tag
    end
  end

  def update
    tag = Tag.find params[:id]
    tag.update create_params
    render_resource tag
  end

  def destroy
    tag = Tag.find params[:id]
    tag.discard
    head :ok
  end

  private

  def create_params
    params.permit(:name)
  end
end
