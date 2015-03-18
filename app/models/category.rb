class Category < ActiveRecord::Base
  has_many :keywords
  belongs_to :catalog
  validates_presence_of :name, message: '請填寫分類名稱'
end