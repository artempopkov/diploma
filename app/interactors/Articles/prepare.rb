module Articles
  class Prepare
    include Interactor

    def call
      begin
        context.article.status = 'prepared'
        context.article.save
      rescue StandardError => exception
        context.fail!(message: exception.message)
      end
    end
  end
end
