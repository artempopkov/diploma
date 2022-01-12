module Admin
  class ReviewPolicy < ApplicationPolicy
    def show?
      moderator.correspondent?
    end

    def new?
      create?
    end

    def create?
      moderator.editor?
    end
  end
end
