class UserHistoryService
  def initialize(user)
    @user = user
  end

  def likes_amount
    user.votes.count
  end

  def likes_history
    user.votes.each_with_object([]) do |vote, history|
      history <<= [Article.find(vote.votable_id), vote.created_at]
    end
  end

  def views_amount
    user.views.group(:impressionable_id).count.count
  end

  def views_history
    user.views.each_with_object([]) do |view, history|
      history <<= [Article.find(view.impressionable_id), view.created_at]
    end
  end

  def comments_amount
    user.comments.count
  end

  def comments_history
    user.comments.each_with_object([]) do |comment, history|
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
