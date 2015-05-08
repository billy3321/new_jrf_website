class Admin::CategorysController < Admin::BaseController
  before_action :set_category, except: [:index, :new]

  # GET /categories
  def index
    @q = Category.search(params[:q])
    @categories = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "文章管理"
    })
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    set_meta_tags({
      title: "新增文章"
    })
  end

  # GET /categories/1/edit
  def edit
    set_meta_tags({
      title: "編輯文章"
    })
  end

  # POST /categories
  def create
    if @category.save
      redirect_to admin_category_url(@category), notice: '文章建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to admin_category_url(@category), notice: '文章更新成功'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to admin_categories_url, notice: '文章已刪除'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = params[:id] ? Category.find(params[:id]) : Category.new(category_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:user_id, :published, {:issue_ids => []},
      :published_at, :kind, :image, :image_cache, :remove_image, :title, :content, :youtube_url)
  end
end
