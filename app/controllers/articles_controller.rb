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

    set_meta_tags({
      title: "所有文章",
      og: {
        title: "所有文章"
      }
    })

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
    set_meta_tags({
      title: "新聞稿",
      og: {
        title: "新聞稿"
      }
    })
  end

  def activities
    @q = Article.activities.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "最新活動",
      og: {
        title: "最新活動"
      }
    })
  end

  def comments
    @q = Article.comments.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "評論文章",
      og: {
        title: "評論文章"
      }
    })
  end

  def epapers
    @q = Article.epapers.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "電子報",
      og: {
        title: "電子報"
      }
    })
  end

  def books
    @q = Article.books.published.search(params[:q])
    @articles = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "出版品",
      og: {
        title: "出版品"
      }
    })
  end

  # GET /articles/1
  def show
    unless @article.published
      not_found
    end
    keywords = @article.keywords.to_a.map{ |k| k.name }.join(',')
    set_meta_tags({
      title: @article.title,
      description: @article.description,
      keywords: keywords,
      og: {
        type: 'article',
        image: @article.image,
        title: @article.title,
        description: @article.description
      }
    })

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
