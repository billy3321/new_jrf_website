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

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  def create
    if @video.save
        redirect_to @video, notice: '文章建立成功'
    else
      render :new
    end
  end

  # PATCH/PUT /videos/1
  def update
    if @video.update(video_params)
      redirect_to @video, notice: '文章更新成功'
    else
      render :edit
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
    redirect_to videos_url, notice: '文章已刪除'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = params[:id] ? Video.find(params[:id]) : Video.new(video_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :content, :published, :published_at,
        {keyword_ids: []}, :image, :description, :author, :user_id)
    end
end
