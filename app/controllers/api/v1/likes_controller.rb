class Api::V1::LikesController < ApplicationController
  before_action :set_like, only: %i[show destroy]

  def show
    render json: @like
  end

  def create
    @like = Like.new(like_params)
    if @like.save
      render json: @like, status: :created
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @like.destroy!
      render json: { status: 'Unliked' }, status: :no_content
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  private

  def set_like
    @like = Like.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'like id not found' }, status: :not_found
  end

  def like_params
    params.require(:like).permit(:author_id, :likeable_type, :likeable_id)
  end
end
