class Wiki < ActiveRecord::Base
  extend FriendlyId

  belongs_to :owner, class_name: "User"
  has_many :pages, dependent: :destroy
  # has_many :collaborations
  # has_many :collaborators, through: :collaborations, source: :user
  # has_many :users, through :collaborations

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  friendly_id :title, use: :slugged
end
