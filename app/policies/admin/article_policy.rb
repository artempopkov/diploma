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
      article.created? or article.rejected? or article.prepared?
    end

    def destroy?
      (article.created? or article.rejected?) and (moderator.correspondent? or moderator.admin?)
    end

    def prepare?
      (article.created? or article.rejected?) and moderator.correspondent?
    end

    def publish?
      (article.accepted? or article.archived) and (moderator.admin? or moderator.editor?)
    end

    def remove_avatar?
      edit?
    end

    class Scope < Scope
      def resolve
        if moderator.admin?
          scope.all
        elsif moderator.editor?
          scope.where(status: %i[prepared accepted published])
        elsif moderator.correspondent?
          scope.where(moderator_id: moderator.id)
        else
          scope.none
        end
      end
    end
  end
end
