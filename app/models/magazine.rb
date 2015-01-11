class Magazine < ActiveRecord::Base
  has_many :magazine_articles
  has_many :columns, through: :magazine_articles
  before_save :update_name
  default_scope { order(created_at: :desc) }

  def update_name
    self.name = "司改雜誌第#{self.issue}期"
  end
end
