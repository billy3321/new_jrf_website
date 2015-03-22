class StaticPagesController < ApplicationController
  def home
    @keywords = Keyword.showed
    @articles = Article.all.page(params[:page]).per(10)
    @magazine_article = MagazineArticle.first
  end

  def about
  end
end
