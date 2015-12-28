class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :keywords, -> { uniq }
  default_scope { order(published_at: :desc) }
  scope :published, -> { where("published = ? AND published_at <= ?", true, Time.now) }
  mount_uploader :image, ImageUploader
  paginates_per 15
  scope :activities, -> { where(kind: 'activity') }
  scope :presses, -> { where(kind: 'press') }
  # scope :videos, -> { where(kind: 'video') }
  scope :comments, -> { where(kind: 'comment') }
  scope :epapers, -> { where(kind: 'epaper') }
  scope :books, -> { where(kind: 'book') }
  before_save :update_youtube_values
  validate :check_content
  validates_presence_of :published_at

  def update_youtube_values
    if self.youtube_url.blank?
      self.youtube_id = nil
      return true
    end
    youtube_id = extract_youtube_id(self.youtube_url)
    unless youtube_id
      self.youtube_url = nil
      self.youtube_id = nil
      errors.add(:base, 'youtube網址錯誤')
      return false
    end
    if self.youtube_id == youtube_id
      # means that youtube is the same, no need to update.
      return nil
    end
    self.youtube_id = youtube_id
    self.youtube_url = "https://www.youtube.com/watch?v=" + self.youtube_id
  end

  private

  def extract_youtube_id(url)
    youtube_uri = URI.parse(url)
    if youtube_uri.host == 'www.youtube.com'
      params = youtube_uri.query
      if params
        youtube_id = CGI::parse(params)['v'].first
      else
        youtube_id = youtube_uri.path.split('/')[-1]
      end
    elsif youtube_uri.host == 'youtu.be'
      youtube_id = youtube_uri.path[1..-1]
    else
      self.youtube_url = nil
      errors.add(:base, 'youtube網址錯誤')
      return false
    end
  end

  def check_content
    unless self.kind == 'system'
      errors.add(:content, '內容不能為空') if self.content.strip.blank?
    end
  end
end
