class ColumnsController < ApplicationController
  before_action :set_column, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /columns
  def index
    @columns = Column.all.page(params[:page])
  end

  # GET /columns/1
  def show
  end

  # GET /columns/new
  def new
    @column = Column.new
  end

  # GET /columns/1/edit
  def edit
  end

  # POST /columns
  def create
    if @column.save
        redirect_to @column, notice: '專欄建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /columns/1
  def update
    if @column.update(column_params)
      redirect_to @column, notice: '專欄更新成功'
    else
      render :edit
    end
  end

  # DELETE /columns/1
  def destroy
    @column.destroy
    redirect_to columns_url, notice: '專欄已刪除'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = params[:id] ? Column.find(params[:id]) : Column.new(column_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def column_params
      params.require(:column).permit(:name)
    end
end
