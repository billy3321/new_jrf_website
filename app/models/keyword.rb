class Keyword < ActiveRecord::Base
  has_and_belongs_to_many :articles, -> { uniq }
  has_and_belongs_to_many :magazine_articles, -> { uniq }
end
