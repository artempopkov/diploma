class UserHistoryService
  module EVENT_TYPE
    LIKE = "like"
    VIEW = "view"
    COMMENT = "comment"
  end

  def initialize(user)
    @user = user
  end

  def user_history
    likes_history = find_voted_items.product([EVENT_TYPE::LIKE])
  
    viewed_articles = Article.find(views.pluck(:impressionable_id).uniq)
    views_history = viewed_articles.product([EVENT_TYPE::VIEW])

    comments_history = comments.to_a.product([EVENT_TYPE::COMMENT])

    likes_history + views_history + comments_history
  end



  attr_reader :user

  def likes_history
    user.votes.each_with_object([]) do |vote, likes_history|
      likes_history <<= [Article.find(vote.votable_id), vote.created_at]
    end
  end

  def viewes_history
    views.each_with_object([]) do |view, views_history|
      views_history <<= [Article.find(view.impressionable_id), view.created_at]
    end
  end
end
