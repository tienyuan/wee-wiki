class PagePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (user.present? && user == record.wiki.owner) || (user.present? && record.wiki.users.exists?(user)) || (record.wiki.private == false)
  end

  def update?
    user == record.wiki.owner || record.wiki.users.exists?(user) || record.wiki.private == false
  end
end