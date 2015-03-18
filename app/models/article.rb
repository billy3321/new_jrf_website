class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :catalog
  belongs_to :category
  has_and_belongs_to_many :keywords, -> { uniq }
  default_scope { order(created_at: :desc) }
  scope :published, -> { where(published: true) }
  mount_uploader :image, ImageUploader
end
