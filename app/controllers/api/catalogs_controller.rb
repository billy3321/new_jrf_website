class Api::CatalogsController < ApplicationController
  respond_to :json

  swagger_controller :catalogs, 'Catalogs'

  swagger_api :index do
    summary '主分類列表'
    notes '回應、查詢主分類列表'
    param :query, :query, :string, :optional, "查詢主分類名稱"
    param :query, :limit, :integer, :optional, "一次顯示多少筆"
    param :query, :offset, :integer, :optional, "從第幾筆開始顯示"
   response :ok, "Success", :APICatalogIndex
  end

  def index
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:name_cont] = params[:query] if params[:query]
    if ransack_params.blank?
      @catalogs = Catalog.includes(categories: :keywords).published.offset(params[:offset]).limit(limit)
      @catalogs_count = Catalog.published.count
    else
      @catalogs = Catalog.includes(categories: :keywords).ransack(ransack_params).result(distinct: true)
        .published.offset(params[:offset]).limit(limit)
      @catalogs_count = Catalog.ransack(ransack_params).result(distinct: true).published.count
    end
    respond_with(@catalogs, @catalogs_count)
  end

  swagger_api :show do
    summary '單一主分類'
    notes '回應單一主分類資訊'
    param :path, :id, :integer, :optional, "文章 Id"
    response :ok, "Success", :APICatalogShow
    response :not_found
  end

  def show
    @catalog = Catalog.includes(categories: :keywords).find(params[:id])
    respond_with(@catalog)
  end

  swagger_model :APICatalogIndex do
    description "Catalog show structure"
    property :count, :integer, :required, "主分類數"
    property :catalogs, :array, :required, "主分類列表", items: { '$ref' => :Catalog }
    property :status, :string, :required, "狀態"
  end

  swagger_model :APICatalogShow do
    description "Catalog show structure"
    property :catalog, nil, :required, "主分類", '$ref' => :Catalog
    property :status, :string, :required, "狀態"
  end

  swagger_model :Catalog do
    description "文章"
    property :id, :integer, :required, "主分類 Id"
    property :name, :string, :required, "主分類名稱"
    property :image, :string, :required, "圖片網址"
    property :categories, :array, :required, "子分類", items: { '$ref' => :Category }
  end

  swagger_model :Category do
    description "子分類"
    property :id, :integer, :required, "子分類 Id"
    property :name, :string, :required, "子分類名稱"
    property :keywords, :array, :required, "關鍵字", items: { '$ref' => :SimpleKeyword }
  end

  swagger_model :SimpleKeyword do
    description "關鍵字"
    property :id, :integer, :required, "關鍵字 Id"
    property :name, :string, :required, "關鍵字名稱"
  end
end