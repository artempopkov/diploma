module Articles
  class Important
    include Interactor

    def call
      context.article.update!(important: context.important)
    rescue StandardError => exception
      context.fail!(message: exception.message)
    end
  end
end
