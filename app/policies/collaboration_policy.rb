class CollaborationPolicy < ApplicationPolicy
  def index
    true
  end

  def create?
      user.present? && (user == record.wiki.owner || record.wiki.private == false)
  end
end