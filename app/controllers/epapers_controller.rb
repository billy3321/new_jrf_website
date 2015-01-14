class EpapersController < ApplicationController
  before_action :set_epaper, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /epapers
  def index
    @epapers = Epaper.all.page(params[:page])
  end

  # GET /epapers/1
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_epaper
      @epaper = params[:id] ? Epaper.find(params[:id]) : Epaper.new(epaper_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def epaper_params
      params.require(:epaper).permit()
    end
end
