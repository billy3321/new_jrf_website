class StaticPagesController < ApplicationController
  def home
    @keywords = Keyword.showed
    @articles = Article.includes(:keywords).published.page(params[:page]).per(9)
    @epaper_article = Article.epapers.first
    @book_articles = Article.books
  end

  def search
    q = params[:q]
    @articles = Article.published.search(title_or_content_cont: q).result.page(params[:page])
    # @videos = Video.published.search(title_or_content_cont: q).result.page(params[:videos_page])
    # @kinds = []
    # @articles.each do |a|
    #   unless @kinds.include? a.kind
    #     @kinds << a.kind if a.kind
    #   end
    # end
    # puts @kinds
    set_meta_tags({
      title: "搜尋文章",
      og: {
        title: "搜尋文章"
      }
    })
  end

  def about
    @article = Article.find(1)
    set_meta_tags({
      title: "關於我們",
      og: {
        title: "關於我們",
        image: @article.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf-img.png" : "#{Setting.url.protocol}://#{Setting.url.host}#{@article.image}"
      }
    })
  end

  def donate
    @article = Article.find(2)
    set_meta_tags({
      title: "捐款支持",
      og: {
        title: "捐款支持",
        image: @article.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf-img.png" : "#{Setting.url.protocol}://#{Setting.url.host}#{@article.image}"
      }
    })
  end

  def sitemap
    @articles = Article.all
  end
end
