class Kind < ActiveRecord::Base
  belongs_to :category
  has_many :articles
  mount_uploader :image, ImageUploader
  mount_uploader :cover, ImageUploader
  scope :published, -> { where(published: true) }
  scope :showed, -> { where(showed: true) }
end
