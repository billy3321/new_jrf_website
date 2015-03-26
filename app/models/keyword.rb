class Keyword < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :articles, -> { uniq }
  has_and_belongs_to_many :magazine_articles, -> { uniq }
  validates_presence_of :name, message: '請填寫關鍵字名稱'
  mount_uploader :image, ImageUploader
  mount_uploader :cover, ImageUploader
  scope :published, -> { where(published: true) }
  scope :showed, -> { where(showed: true) }
end
