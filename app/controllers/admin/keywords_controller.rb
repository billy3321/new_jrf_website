class Admin::KeywordsController < Admin::BaseController
  before_action :set_keyword, except: [:index, :new]

  # GET /keywords
  def index
    @q = Keyword.search(params[:q])
    @keywords = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "文章管理"
    })
  end

  # GET /keywords/1
  def show
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
    set_meta_tags({
      title: "新增文章"
    })
  end

  # GET /keywords/1/edit
  def edit
    set_meta_tags({
      title: "編輯文章"
    })
  end

  # POST /keywords
  def create
    if @keyword.save
      redirect_to admin_keyword_url(@keyword), notice: '文章建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /keywords/1
  def update
    if @keyword.update(keyword_params)
      redirect_to admin_keyword_url(@keyword), notice: '文章更新成功'
    else
      render :edit
    end
  end

  # DELETE /keywords/1
  def destroy
    @keyword.destroy
    redirect_to admin_keywords_url, notice: '文章已刪除'
  end

  def sort
    keyword_params[:order].each do |key,value|
      Keyword.find(value[:id]).update_attribute(:position, value[:position])
    end
    render :nothing => true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_keyword
    @keyword = params[:id] ? Keyword.find(params[:id]) : Keyword.new(keyword_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def keyword_params
    params.require(:keyword).permit(:user_id, :published, {:issue_ids => []},
      :published_at, :kind, :image, :image_cache, :remove_image, :title, :content, :youtube_url)
  end
end
