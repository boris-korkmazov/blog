class ArticlesController < ApplicationController
  
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @articles = Article.all
    if @articles.count.zero?
      redirect_to new_article_path
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.build
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.valid?
      @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(article_params)
    if @article.save
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_url
  end

  private

    def article_params 
      params.require(:article).permit(:title, :text)
    end
end
