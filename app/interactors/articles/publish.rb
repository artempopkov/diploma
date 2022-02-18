module Articles
  class Publish
    include Interactor

    def call
      context.article.update!(status: "published")
      context.article.update!(published_at: Time.zone.now)
    rescue StandardError => exception
      context.fail!(message: exception.message)
    end
  end
end
