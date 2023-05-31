class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]

  # GET /api/v1/articles
  def index
    @articles = Article.all
    @articles = @articles.status_filter(params[:status]) if params[:status].present?
    @articles = @articles.author_filter(params[:author]) if params[:author].present?
    @articles = @articles.tag_filter(params[:tags]) if params[:tags].present?
    @pagy, @articles = pagy(@articles, page: params[:page], items: 15)
    if @articles
      render json: { data: @articles }, status: :ok
    else
      render json: @articles.errors, status: :bad_request
    end
  end

  def order
    @result = Article.all.order(title: params[:order])
    render json: { data: @result }, status: :ok
  end

  def search
    @result = Article.all.where('title||body ILIKE ?', "%#{params[:q]}%")
    if @result.blank?
      render json: { message: 'Article not found' }, status: :ok
    else
      render json: { data: @result }, status: :ok
    end
  end

  def show
    render json: @article, each_serializer: Api::V1::ArticleSerializer, status: :ok
  end

  # POST /api/v1/articles
  def create
    @article = Article.new(article_params)
    if @article.save
      render json: { data: @article }, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/articles/1
  def update
    if @article.update(article_params)
      render json: { status: 'Update', data: @article }, status: :ok
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/articles/1
  def destroy
    if @article.destroy!
      render json: { status: 'Delete' }, status: :ok
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    logger.info e
    render json: { message: 'article id not found' }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.permit(:title, :body, :status, :author_id)
  end
end
