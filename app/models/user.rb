class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :owned_wikis, class_name: 'Wiki', foreign_key: 'owner_id'
  has_many :collaborations
  has_many :wikis, through: :collaborations
end
