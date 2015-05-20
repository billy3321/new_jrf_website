class Category < ActiveRecord::Base
  has_many :keywords
  belongs_to :catalog
  validates_presence_of :name, message: '請填寫分類名稱'
  validates_presence_of :catalog_id, message: '請選擇主分類'
  scope :published, -> { where(published: true) }
  default_scope { order(position: :asc) }
  before_save :set_position
  validates_uniqueness_of :name, message: '請確認名稱沒有重複'

  def full_name
    "#{self.catalog.name} > #{self.name}"
  end

  def set_position
    if not self.position
      self.position = Category.maximum("position").to_i + 1
    end
  end
end