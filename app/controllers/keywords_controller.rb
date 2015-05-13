class KeywordsController < ApplicationController
  before_action :set_keyword, except: [:index, :new]

  # GET /keywords
  def index
    @keywords = Keyword.all.page params[:page]
  end

  # GET /keywords/1
  def show
    unless @keyword.published
      not_found
    end
    unless params[:k].blank?
      @issue = params[:k] if ['presses', 'comments', 'activities', 'epapers', 'books'].include? params[:k]
    else
      @issue = nil
    end
    if @issue == 'presses'
      @articles = @keyword.articles.presses.publiced.page params[:page]
    elsif @issue == 'comments'
      @articles = @keyword.articles.comments.publiced.page params[:page]
    elsif @issue == 'activities'
      @articles = @keyword.articles.activities.publiced.page params[:page]
    elsif @issue == 'epapers'
      @articles = @keyword.articles.epapers.publiced.page params[:page]
    elsif @issue == 'books'
      @articles = @keyword.articles.books.publiced.page params[:page]
    else
      @articles = @keyword.articles.publiced.page params[:page]
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_keyword
    @keyword = params[:id] ? Keyword.find(params[:id]) : Keyword.new(keyword_params)
  end
end