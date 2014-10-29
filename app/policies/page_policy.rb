class PagePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (user.present? && User.allowed_users(record.wiki).include?(user))  || record.wiki.private == false
  end

  # def create?
  #   (user.present? && User.allowed_users(record.wiki).include?(user))  || (user.present? && record.wiki.private == false)
  # end
  # this doesn't work because there is no record to find a wiki with

  def update?
    (user.present? && User.allowed_users(record.wiki).include?(user))  || (user.present? && record.wiki.private == false)
  end
end