class ArticlesController < ApplicationController
  before_action :set_article, except: [:index, :new, :presses, :activities, :comments, :epapers, :books]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /articles
  def index
    @q = Article.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def presses
    @q = Article.presses.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def activities
    @q = Article.activities.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def comments
    @q = Article.comments.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def epapers
    @q = Article.epapers.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  def books
    @q = Article.books.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
  end

  # GET /articles/1
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = params[:id] ? Article.find(params[:id]) : Article.new(article_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit()
  end
end
