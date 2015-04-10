class KeywordsController < ApplicationController
  before_action :set_keyword, except: [:index, :new]

  # GET /keywords
  def index
    @keywords = Keyword.all.page params[:page]
  end

  # GET /keywords/1
  def show
    @articles = @keyword.articles.page params[:articles_page]
    @videos = @keyword.videos.page params[:videos_page]
    @kinds = []
    @articles.each do |a|
      unless @kinds.include? a.kind
        @kinds << a.kind if a.kind
      end
    end
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords
  def create
    @keyword = Keyword.new(keyword_params)
    if @keyword.save
        redirect_to @keyword, notice: 'Keyword was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /keywords/1
  def update
    if @keyword.update(keyword_params)
      redirect_to @keyword, notice: 'Keyword was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /keywords/1
  def destroy
    @keyword.destroy
    redirect_to keywords_url, notice: 'Keyword was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = params[:id] ? Keyword.find(params[:id]) : Keyword.new(keyword_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_params
      params.require(:keyword).permit(:name, :published, :showed, :image, :category_id, :title, :image, :description)
    end
end