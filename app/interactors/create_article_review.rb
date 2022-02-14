class CreateArticleReview
  include Interactor::Organizer

  organize UpdateArticleReviewStatus, UpdateArticleStatus
end
