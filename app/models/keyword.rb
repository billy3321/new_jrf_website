class Keyword < ActiveRecord::Base
  belongs_to :category
  belongs_to :catalog, through: :category
  accepts_nested_attributes_for :faqs, :reject_if => :all_blank, :allow_destroy => true
  has_many :faqs, :dependent => :destroy
  has_and_belongs_to_many :articles, -> { uniq }
  has_and_belongs_to_many :videos, -> { uniq }
  has_and_belongs_to_many :magazine_articles, -> { uniq }
  validates_presence_of :name, message: '請填寫關鍵字名稱'
  mount_uploader :image, ImageUploader
  mount_uploader :cover, ImageUploader
  scope :published, -> { where(published: true) }
  scope :showed, -> { where(showed: true) }
  default_scope { order(position: :asc) }

  before_save :set_position

  def set_position
    if not self.position
      self.position = Banner.maximum("position").to_i + 1
    end
  end
end
