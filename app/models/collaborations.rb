class Collaborations < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :user
end