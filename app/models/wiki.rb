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
      public_wikis = Wiki.where(private: false) #public
      owned_wikis = Wiki.where(owner_id: user.id)
      collaborations_wikis = user.wikis
      public_wikis + owned_wikis + collaborations_wikis
    else
      Wiki.where(private: false)
    end
  end

  # scope :publicly_viewable, -> { where(private: false) }
  # scope :privately_viewable, -> { where(private: true) }
  # scope :owner, -> (user) { privately_viewable.where(owner_id: user.id) }
  # scope :user, (user) -> { privately_viewable.where(user_id: user.id) } # shows this to you if you are a wiki's user
  # then wiki index shows the union of public, owner and user

  # OR show all except private wikis that dont show you as a collaborator or owner?
  # scope :not_user, (user) -> { where(user_id: user.id) } # shows this to you if you are a wiki's user
  # wiki index should show
  # wikis that are publically viewable... via 'publicly_viewable'
  # wikis you own ... via 'owner(current_user)'
  # wikis you are a collaborator on

end
