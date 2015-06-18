class ArticlesController < ApplicationController
  before_action :set_article, except: [:index, :new, :presses, :activities, :comments, :epapers, :books]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /articles
  def index
    if params[:format] == "json"
      if params[:query]
        @articles = Article.published.ransack({title_or_content_cont: params[:query]}).result(distinct: true)
          .published.offset(params[:offset]).limit(params[:limit])
        @articles_count = Article.published.ransack({title_or_content_cont: params[:query]}).result(distinct: true)
          .published.count
      else
        @articles = Article.published.offset(params[:offset]).limit(params[:limit])
        @articles_count = Article.published.count
      end
    else
      @q = Article.published.search(params[:q])
      @articles = @q.result(distinct: true).page(params[:page])
    end

    respond_to do |format|
      format.html
      format.json { render :json => {
          status: "success",
          articles: JSON.parse(
            @articles.to_json({include: [:keywords], except: [:published]})
          ),
          count: @articles_count
        },
        callback: params[:callback]
      }
    end
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
    unless @article.published
      not_found
    end
    respond_to do |format|
      format.html
      format.json { render :json => {
        status: "success",
        article: JSON.parse(
            @article.to_json({include: [:issues], except: [:published]})
          ),
        callback: params[:callback]
        }
      }
    end
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
