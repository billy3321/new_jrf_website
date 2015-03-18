class Catalog < ActiveRecord::Base
  has_many :categories
  validates_presence_of :name, message: '請填寫分類名稱'
  mount_uploader :image, ImageUploader
end
