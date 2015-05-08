class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :keywords, -> { uniq }
  default_scope { order(created_at: :desc) }
  scope :published, -> { where(published: true) }
  mount_uploader :image, ImageUploader
  paginates_per 15
  scope :activities, -> { where(kind: 'activity') }
  scope :presses, -> { where(kind: 'press') }
  scope :epapers, -> { where(kind: 'epaper') }
  scope :books, -> { where(kind: 'book') }
end
