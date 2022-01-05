module Admin
  class CategoryPolicy < ApplicationPolicy
    def index?
      moderator_editor_or_admin?
    end

    def create?
      moderator_editor_or_admin?
    end

    def new?
      create?
    end

    def update?
      moderator_editor_or_admin?
    end

    def edit?
      update?
    end

    def destroy?
      moderator_editor_or_admin?
    end

    private

    def moderator_editor_or_admin?
      moderator.editor? || moderator.admin?
    end
  end
end
