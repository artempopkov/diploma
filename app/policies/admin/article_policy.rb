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
      article.inactive? and (moderator.correspondent? or moderator.admin?)
    end

    def send_for_review?
      article.inactive? and moderator.correspondent?
    end

    def publish?
      article.active? and (moderator.admin? or moderator.editor?)
    end

    def remove_avatar?
      edit?
    end

    def mark_as_important?
      moderator.editor? or moderator.admin?
    end

    class Scope < Scope
      def resolve
        if moderator.admin?
          scope.all
        elsif moderator.editor?
          scope.where(status: %i[active published])
        elsif moderator.correspondent?
          scope.where(moderator_id: moderator.id)
        else
          scope.none
        end
      end
    end
  end
end
