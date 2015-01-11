class MagazineArticlesController < ApplicationController
  before_action :set_magazine_article, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /magazine_articles
  def index
    @q = MagazineArticle.search(params[:q])
    @magazine_articles = @q.result(distinct: true).page(params[:page])
  end

  # GET /magazine_articles/1
  def show
  end

  # GET /magazine_articles/new
  def new
    @magazine_article = MagazineArticle.new
  end

  # GET /magazine_articles/1/edit
  def edit
  end

  # POST /magazine_articles
  def create
    if @magazine_article.save
        redirect_to @magazine_article, notice: '雜誌文章建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /magazine_articles/1
  def update
    if @magazine_article.update(magazine_article_params)
      redirect_to @magazine_article, notice: '雜誌文章更新成功'
    else
      render :edit
    end
  end

  # DELETE /magazine_articles/1
  def destroy
    @magazine_article.destroy
    redirect_to magazine_articles_url, notice: '雜誌文章已刪除'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_magazine_article
      @magazine_article = params[:id] ? MagazineArticle.find(params[:id]) : MagazineArticle.new(magazine_article_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def magazine_article_params
      params.require(:magazine_article).permit(:title, :content, :published_at, :comment, :magazine_id, :column_id,
        {keyword_ids: []}, :author, :comment)
    end
end
