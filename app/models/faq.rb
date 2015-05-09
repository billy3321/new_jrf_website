class Faq < ActiveRecord::Base
  belongs_to :keyword
  validates_presence_of :question, :answer, :keyword_id
end
