class CollaborationPolicy < ApplicationPolicy
  def index
    true
  end

  def create?
    user.present? && (user == record.wiki.owner)
  end
end
