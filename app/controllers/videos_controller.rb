class VideosController < ApplicationController
  before_action :set_video, except: [:index, :new]
  #before_action :authenticate_user!, except: [:show, :index]

  # GET /videos
  def index
    @q = Video.search(params[:q])
    @videos = @q.result(distinct: true).page(params[:page])
  end

  # GET /videos/1
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = params[:id] ? Video.find(params[:id]) : Video.new(video_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit()
    end
end
