class Page < ActiveRecord::Base
  belongs_to :wiki

  validates :name, presence: true
  validates :body, presence: true
end
