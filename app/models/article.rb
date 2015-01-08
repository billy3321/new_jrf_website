class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :catalog
  belongs_to :category
  belongs_to :keyword
end
