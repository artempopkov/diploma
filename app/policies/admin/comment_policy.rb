module Admin
  class CommentPolicy < ApplicationPolicy
    def index?
      moderator.admin?
    end

    def destroy?
      moderator.admin?
    end
  end
end
