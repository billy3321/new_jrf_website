class Admin::CatalogsController < Admin::BaseController
  before_action :set_catalog, except: [:index, :new]

  # GET /catalogs
  def index
    @q = Catalog.search(params[:q])
    @catalogs = @q.result(distinct: true).page(params[:page])
    set_meta_tags({
      title: "文章管理"
    })
  end

  # GET /catalogs/1
  def show
  end

  # GET /catalogs/new
  def new
    @catalog = Catalog.new
    set_meta_tags({
      title: "新增文章"
    })
  end

  # GET /catalogs/1/edit
  def edit
    set_meta_tags({
      title: "編輯文章"
    })
  end

  # POST /catalogs
  def create
    if @catalog.save
      redirect_to admin_catalog_url(@catalog), notice: '文章建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /catalogs/1
  def update
    if @catalog.update(catalog_params)
      redirect_to admin_catalog_url(@catalog), notice: '文章更新成功'
    else
      render :edit
    end
  end

  # DELETE /catalogs/1
  def destroy
    @catalog.destroy
    redirect_to admin_catalogs_url, notice: '文章已刪除'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_catalog
    @catalog = params[:id] ? Catalog.find(params[:id]) : Catalog.new(catalog_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def catalog_params
    params.require(:catalog).permit(:user_id, :published, {:issue_ids => []},
      :published_at, :kind, :image, :image_cache, :remove_image, :title, :content, :youtube_url)
  end
end
