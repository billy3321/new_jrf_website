class KeywordsController < ApplicationController
  before_action :set_keyword, except: [:index, :new]

  # GET /keywords
  def index
    @keywords = Keyword.all.page params[:page]
  end

  # GET /keywords/1
  def show
    
    unless params[:k].blank?
      @issue = params[:k] if ['presses', 'comments', 'activities', 'epapers', 'books'].include? params[:k]
    else
      @issue = nil
    end
    if @issue = 'presses'
      @articles = @keyword.articles.presses.page params[:page]
    elsif @issue = 'comments'
      @articles = @keyword.articles.comments.page params[:page]
    elsif @issue = 'activities'
      @articles = @keyword.articles.activities.page params[:page]
    elsif @issue = 'epapers'
      @articles = @keyword.articles.epapers.page params[:page]
    elsif @issue = 'books'
      @articles = @keyword.articles.books.page params[:page]
    else
      @articles = @keyword.articles.page params[:page]
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_keyword
    @keyword = params[:id] ? Keyword.find(params[:id]) : Keyword.new(keyword_params)
  end
end