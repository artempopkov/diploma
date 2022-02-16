module Articles
  class Publish
    include Interactor

    def call
        context.article.update!(status: 'published')
      rescue StandardError => exception
        context.fail!(message: exception.message)
      end
    end
  end
end
