class Column < ActiveRecord::Base
  has_many :magazine_articles
  validates_presence_of :name, message: '請填寫專欄名稱'
end
