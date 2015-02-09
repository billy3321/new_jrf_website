class MagazineArticle < ActiveRecord::Base
    has_and_belongs_to_many :keywords, -> { uniq }
    belongs_to :magazine
    belongs_to :column

    default_scope {
      includes(:magazine).
      order("magazines.published_at DESC")
    }
end
