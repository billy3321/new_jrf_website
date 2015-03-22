class CatalogsController < ApplicationController
  before_action :set_catalog, except: [:index, :new]

  # GET /catalogs
  def index
    @catalogs = Catalog.all.page params[:page]
  end

  # GET /catalogs/1
  def show
    @articles = @catalog.articles.page params[:page]
  end

  # GET /catalogs/new
  def new
    @catalog = Catalog.new
  end

  # GET /catalogs/1/edit
  def edit
  end

  # POST /catalogs
  def create
    @catalog = Catalog.new(catalog_params)
    if @catalog.save
        redirect_to @catalog, notice: 'Catalog was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /catalogs/1
  def update
    if @catalog.update(catalog_params)
      redirect_to @catalog, notice: 'Catalog was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /catalogs/1
  def destroy
    @catalog.destroy
    redirect_to catalogs_url, notice: 'Catalog was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalog
      @catalog = params[:id] ? Catalog.find(params[:id]) : Catalog.new(catalog_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalog_params
      params.require(:catalog).permit(:name, :image, :published)
    end
end