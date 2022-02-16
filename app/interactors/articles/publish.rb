module Articles
  class Publish
    include Interactor

    def call
      begin
        context.article.status = 'published'
        context.article.save!
      rescue StandardError => exception
        context.fail!(message: exception.message)
      end
    end
  end
end
