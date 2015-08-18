class KeywordsController < ApplicationController
  before_action :set_keyword, except: [:index, :new]

  # GET /keywords
  def index
    if params[:format] == "json"
      if params[:query]
        query = "%#{params[:query]}%"
        @keywords = Keyword.published.where("name LIKE ?", query)
          .limit(params[:limit]).offset(params[:offset])
        count = Keyword.published.where("name LIKE ?", query).count
      else
        @keywords = Keyword.published.limit(params[:limit]).offset(params[:offset])
        count = Keyword.published.count
      end
    else
      if user_signed_in? and current_user.admin?
        @keywords = Keyword.all.page params[:page]
      else
        @keywords = Keyword.published.page params[:page]
      end
    end
    respond_to do |format|
      format.html
      format.json {
        render :json => {
          status: "success",
          keyword: @keywords,
          count: count
        },
        callback: params[:callback]
      }
    end
  end

  # GET /keywords/1
  def show
    unless @keyword.published
      if user_signed_in? and current_user.admin?
      else
        not_found
      end
    end
    unless params[:k].blank?
      @kind = params[:k] if ['presses', 'comments', 'activities', 'epapers', 'books'].include? params[:k]
    else
      @kind = nil
    end
    if @kind == 'presses'
      @articles = @keyword.articles.presses.published.page params[:page]
    elsif @kind == 'comments'
      @articles = @keyword.articles.comments.published.page params[:page]
    elsif @kind == 'activities'
      @articles = @keyword.articles.activities.published.page params[:page]
    elsif @kind == 'epapers'
      @articles = @keyword.articles.epapers.published.page params[:page]
    elsif @kind == 'books'
      @articles = @keyword.articles.books.published.page params[:page]
    else
      @articles = @keyword.articles.published.page params[:page]
    end
    set_meta_tags({
      title: @keyword.title,
      description: @keyword.description,
      og: {
        image: @keyword.image.blank? ? "#{Setting.url.protocol}://#{Setting.url.host}/images/jrf-img.png" : "#{Setting.url.protocol}://#{Setting.url.host}#{@keyword.image}",
        title: @keyword.title,
        description: @keyword.description
      }
    })
    respond_to do |format|
      format.html
      format.json {render :json => {
        status: "success",
        keyword: JSON.parse(@keyword.to_json(
        except: [:published, :created_at, :updated_at],
        include: {
          faqs: {},
          articles: {except: [:published], include: [:keywords]}
        }))},
        callback: params[:callback]
      }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_keyword
    @keyword = params[:id] ? Keyword.find(params[:id]) : Keyword.new(keyword_params)
  end
end