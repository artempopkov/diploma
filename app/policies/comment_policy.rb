class CommentPolicy < ApplicationPolicy
  attr_reader :moderator, :comment

  def initialize(moderator, comment)
    super
    @comment = comment
  end

  def index?
    true
  end

  def create?
    moderator
  end

  def new?
    create?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
