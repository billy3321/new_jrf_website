class MagazineArticle < ActiveRecord::Base
    has_and_belongs_to_many :keywords, -> { uniq }
    belongs_to :magazine
    belongs_to :column
end
