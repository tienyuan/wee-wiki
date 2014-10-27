class Page < ActiveRecord::Base
  extend FriendlyId

  belongs_to :wiki

  validates :title, presence: true
  validates :body, presence: true

  friendly_id :title, use: :slugged
end
