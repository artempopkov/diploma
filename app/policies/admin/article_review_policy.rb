module Admin
  class ArticleReviewPolicy < ApplicationPolicy
    attr_reader :moderator, :article_review

    def initialize(moderator, article_review)
      super
      @article_review = article_review
    end

    def show?
      moderator.correspondent?
    end

    def create?
      moderator.editor? and !article_review.article.created?
    end
  end
end
