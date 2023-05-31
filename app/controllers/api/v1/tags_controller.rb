class Api::V1::TagsController < ApplicationController
  before_action :set_tag, only: %i[show destroy]

  def index
    @tags = Tag.all
    if @tags
      render json: { data: @tags }, status: :ok
    else
      render json: @tags.errors, status: :bad_request
    end
  end

  def show
    @articles_tag = @tag.articles.all
    render json: { tag: @tag, article: @articles_tag }, status: :ok
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag, status: :created
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @tag.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'tag id not found' }, status: :not_found
  end

  def tag_params
    params.require(:tag).permit(:tagname)
  end
end
