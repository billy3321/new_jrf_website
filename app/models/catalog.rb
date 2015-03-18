class Catalog < ActiveRecord::Base
  has_many :category
  validates_presence_of :name, message: '請填寫分類名稱'
end
