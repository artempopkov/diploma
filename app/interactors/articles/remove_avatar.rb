module Articles
  class RemoveAvatar
    include Interactor

    def call
      context.article.remove_avatar!
      context.article.save!
    rescue StandardError => exception
      context.fail!(message: exception.message)
    end
  end
end
