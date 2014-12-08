class PagePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (user.present? && User.allowed_users(record.wiki).include?(user)) || !record.wiki.private
  end

  def create?
    user.present? && (User.allowed_users(record.wiki).include?(user) || !record.wiki.private)
  end

  def update?
    user.present? && (User.allowed_users(record.wiki).include?(user) || !record.wiki.private)
  end
end
