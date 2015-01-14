class Category < ActiveRecord::Base
  has_many :articles
  validates_presence_of :name, message: '請填寫分類名稱'
end