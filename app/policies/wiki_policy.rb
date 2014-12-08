class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (user.present? && User.allowed_users(record).include?(user)) || !record.private
  end

  def update?
    user.present? && (user == record.owner || !record.private)
  end
end
