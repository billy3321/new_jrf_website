class Api::KeywordsController < ApplicationController
  respond_to :json

  swagger_controller :keywords, 'Keywords'

  swagger_api :index do
    summary '關鍵字列表'
    notes '回應、查詢關鍵字列表'
    param :query, :query, :string, :optional, "查詢關鍵字名稱"
    param :query, :limit, :integer, :optional, "一次顯示多少筆"
    param :query, :offset, :integer, :optional, "從第幾筆開始顯示"
    response :ok, "Success", :APIKeywordIndex
  end

  def index
    limit = params[:limit].blank? ? 10 : params[:limit]
    ransack_params = {}
    ransack_params[:title_or_name_cont] = params[:query] if params[:query]
    if ransack_params.blank?
      @keywords = Keyword.includes(category: :catalog).published.offset(params[:offset]).limit(limit)
      @keywords_count = Keyword.published.count
    else
      @keywords = Keyword.includes(category: :catalog).published.ransack(ransack_params).result(distinct: true)
        .offset(params[:offset]).limit(limit)
      @keywords_count = Keyword.published.ransack(ransack_params).result(distinct: true).count
    end
    respond_with(@keywords, @keywords_count)
  end

  swagger_api :show do
    summary '單一關鍵字'
    notes '回應單一關鍵字資訊，與其他文章'
    param :path, :id, :integer, :optional, "關鍵字 Id"
    response :ok, "Success", :APIKeywordShow
    response :not_found
  end

  def show
    @keyword = Keyword.includes(:articles, { category: :catalog }).find(params[:id])
    if @keyword.published
      respond_with(@keyword)
    else
      not_found
    end
  end

  swagger_model :APIKeywordIndex do
    description "Keyword show structure"
    property :count, :integer, :required, "關鍵字數量"
    property :keywords, :array, :required, "關鍵字列表", items: { '$ref' => :Keyword }
    property :status, :string, :required, "狀態"
  end

  swagger_model :APIKeywordShow do
    description "Keyword show structure"
    property :keyword, nil, :required, "關鍵字", '$ref' => :Keyword
    property :status, :string, :required, "狀態"
  end

  swagger_model :Keyword do
    description "關鍵字"
    property :id, :integer, :required, "關鍵字 Id"
    property :name, :string, :required, "關鍵字名稱"
    property :showed, :string, :required, "是否顯示於首頁"
    property :image, :string, :required, "圖片"
    property :cover, :string, :required, "首頁圖片"
    property :title, :string, :required, "標題"
    property :content, :string, :optional, "解說內文"
    property :description, :string, :optional, "簡短描述"
    property :published_at, :date, :required, "發佈時間"
    property :articles, :array, :required, '文章清單', items: { '$ref' => :Article }
    property :category, nil, "子分類", '$ref' => :Category
  end

  swagger_model :Category do
    description "子分類"
    property :id, :integer, :required, "子分類 Id"
    property :name, :string, :required, "子分類名稱"
    property :catalog, nil, "主分類", '$ref' => :Catalog
  end

  swagger_model :Catalog do
    description "主分類"
    property :id, :integer, :required, "主分類 Id"
    property :name, :string, :required, "主分類名稱"
  end
end