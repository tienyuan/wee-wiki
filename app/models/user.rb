class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :wikis
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :wiki
end
