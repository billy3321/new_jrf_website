class Slide < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :slideable, polymorphic: true
  default_scope { order(position: :asc) }
end
