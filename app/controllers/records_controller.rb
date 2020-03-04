class RecordsController < ApplicationController
  before_action :must_sign_in
  before_action :check_resource_owner, only: [:show, :update, :destroy]
  before_action :check_resources_owner, only: [:index]

  def index
    render_resources @records, as_json: {methods: [:tag_ids]}
  end

  def show
    render_resource @record, as_json: {methods: [:tag_ids]}
  end

  def create
    @record = Record.new user: current_user
    @record.update! create_params
    render_resource @record, as_json: {methods: [:tag_ids]}
  end

  def update
    @record.update create_params
    render_resource @record, as_json: {methods: [:tag_ids]}
  end

  def destroy
    @record.discard
    head :ok
  end

  private

  def check_resource_owner
    @record = Record.find params[:id]
    unless @record.user == current_user
      raise CustomError::Forbidden
    end
  end

  def check_resources_owner
    @records = Record.where user: current_user
  end

  def create_params
    params.permit(:amount, :category, tag_ids: [])
  end
end
