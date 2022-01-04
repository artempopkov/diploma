module Admin
  class ArticlePolicy < ApplicationPolicy
    attr_reader :moderator, :article

    def initialize(moderator, article)
      super
      @article = article
    end

    def index?
      true
    end

    def show?
      true
    end

    def new?
      create?
    end

    def create?
      moderator.correspondent?
    end

    def edit?
      update?
    end

    def update?
      article.inactive?
    end

    def destroy?
      article.inactive?
    end

    class Scope < Scope
      def resolve
        if moderator.admin?
          scope.all
        elsif moderator.editor?
          scope.where(status: :active)
        else
          scope.where(status: %i[inactive published], moderator_id: moderator.id)
        end
      end
    end
  end
end
