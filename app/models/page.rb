class Page < ActiveRecord::Base
  belongs_to :wiki

  validates :title, presence: true
  validates :body, presence: true
end
