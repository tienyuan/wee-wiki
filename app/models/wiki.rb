class Wiki < ActiveRecord::Base
  extend FriendlyId

  belongs_to :owner, class_name: "User"
  has_many :pages, dependent: :destroy
  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  friendly_id :title, use: :slugged

  scope :sort_asc, -> { order('title ASC') }

  def self.viewable_wikis(user)
    if user
      Wiki.includes(:collaborations).where("(private = ?) OR (owner_id = ?) OR (collaborations.user_id = ?)", false, user.id, user.id).references(:collaborations)
    else
      Wiki.where(private: false)
    end
  end
end
