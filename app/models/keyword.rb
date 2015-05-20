class Keyword < ActiveRecord::Base
  belongs_to :category
  has_many :faqs, :dependent => :destroy
  accepts_nested_attributes_for :faqs, :reject_if => :all_blank, :allow_destroy => true
  has_and_belongs_to_many :articles, -> { uniq }
  has_and_belongs_to_many :magazine_articles, -> { uniq }
  validates_presence_of :name, message: '請填專案字名稱'
  validates_presence_of :title, message: '請填專案標題'
  validates_presence_of :content, message: '請填專案內文'
  validates_uniqueness_of :name, message: '請確認名稱沒有重複'
  mount_uploader :image, ImageUploader
  mount_uploader :cover, ImageUploader
  scope :published, -> { where(published: true) }
  scope :showed, -> { where(showed: true) }
  default_scope { order(position: :asc) }
  delegate :catalog, to: :category

  before_save :set_position

  def set_position
    if not self.position
      self.position = Keyword.maximum("position").to_i + 1
    end
  end

  def self.build #-> allows you to call a single method
    keyword = self.new
    keyword.faqs.build
    return
 end
end
