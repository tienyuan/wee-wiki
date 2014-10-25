class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :pages, dependent: :destroy
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
end
