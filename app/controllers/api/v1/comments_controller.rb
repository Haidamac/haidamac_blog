class Api::V1::CommentsController < ApplicationController
  before_action :set_author
  before_action :set_article
  before_action :set_comment, only: %i[show update destroy]

  def index
    @comments = @article.comments
    @comments = @comments.where(status: params[:status]) if params[:status].present?
    render json: @comments
  end

  def show
    render json: @comment, status: :ok
  end

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_author
    @author = Author.find_by_id(params[:author_id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'resource id not found' }, status: :not_found
  end

  def set_article
    @article = Article.find_by_id(params[:article_id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'resource id not found' }, status: :not_found
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'resource id not found' }, status: :not_found
  end

  def comment_params
    params.require(:comment).permit(:body, :author_id, :status)
  end
end
