class Category < ActiveRecord::Base
  has_many :keywords
  has_many :kinds
  belongs_to :catalog
  validates_presence_of :name, message: '請填寫分類名稱'
  scope :published, -> { where(published: true) }
end