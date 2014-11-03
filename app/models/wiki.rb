class Wiki < ActiveRecord::Base
  extend FriendlyId

  belongs_to :owner, class_name: "User"
  has_many :pages, dependent: :destroy
  has_many :collaborations
  has_many :users, through: :collaborations

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  friendly_id :title, use: :slugged

  def self.viewable_wikis(user)

    if user
      # Wiki.joins(:collaborations).where("(private = ?) OR (owner_id = ?) OR (collaborations.user_id = ?)", false, user.id, user.id)
      public_wikis = Wiki.where(private: false)
      owned_wikis = Wiki.where("owner_id = ? AND private = ?", user.id, true)
      collaborations_wikis = user.wikis
      (public_wikis + owned_wikis + collaborations_wikis)
    else
      Wiki.where(private: false)
    end
  end
end
