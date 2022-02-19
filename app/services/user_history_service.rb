class UserHistoryService
  def initialize(user)
    @user = user
  end

  def likes_amount
    user.votes.count
  end

  def likes
    user.votes.includes(:votable).each_with_object([]) do |vote, history|
      history <<= [vote.votable, vote.created_at]
    end
  end

  def views_amount
    user.views.group(:impressionable_id).count.count
  end

  def views
    views = user.views.includes(:impressionable).each_with_object([]) do |view, history|
      history <<= [view.impressionable, view.created_at]
    end
    views.to_h.to_a
  end

  def comments_amount
    user.comments.count
  end

  def comments
    user.comments.includes(:article).each_with_object([]) do |comment, history|
      history <<= [comment, comment.created_at]
    end
  end

  private 

  attr_reader :user

  # def prepare_history(action_type, identificator)
  #   user.action_type.each_with_object([]) do |action, history|
  #     history <<= [Article.find(action.identificator), action.created_at]
  #   end
  # end
end
