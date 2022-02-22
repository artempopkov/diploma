class ArticlePolicy < ApplicationPolicy
  attr_reader :moderator, :article

  def initialize(moderator, article)
    super
    @article = article
  end

  def show?
    true
  end

  def like?
    moderator
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
