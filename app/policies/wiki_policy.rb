class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (user.present? && user == record.owner) || (user.present? && record.users.exists?(user)) || (record.private == false)
  end

  def update?
    user.present? && (user == record.owner || record.private == false)
  end
end