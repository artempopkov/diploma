class UserPolicy < ApplicationPolicy
  attr_reader :moderator, :user

  def initialize(moderator, user)
    super
    @user = user
  end

  def show?
    true
  end

  class Scope < Scope
    def resolve
      moderator.id == user.id
    end
  end
end
