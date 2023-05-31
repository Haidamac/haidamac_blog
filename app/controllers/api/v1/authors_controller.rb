class Api::V1::AuthorsController < ApplicationController
  before_action :set_author, only: %i[show, destroy]

  def index
    @authors = Author.all
    render json: { data: @authors }, status: :ok
  end

  def show
    render json: { data: @author }, status: :ok
  end

  def create
    @author = Author.create
    if @author.save
      render json: { data: @author }, status: :ok
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @author.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def set_author
    @author = Author.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'author id not found' }, status: :not_found
  end
end
