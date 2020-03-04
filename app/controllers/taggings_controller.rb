class TaggingsController < ApplicationController
  before_action :must_sign_in

  def index
    taggings = Tagging.where user: current_user
    render_resources taggings
  end

  def show
    tagging = Tagging.find params[:id]
    render_resource tagging
  end

  def create
    tagging = Tagging.create create_params.merge user: current_user
    render_resource tagging
  end

  def destroy
    tagging = Tagging.find params[:id]
    tagging.discard
    head :ok
  end

  private

  def create_params
    params.permit(:tag_id, :record_id)
  end
end
