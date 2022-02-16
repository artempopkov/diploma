module Articles
  class Prepare
    include Interactor

    def call
      begin
        context.article.update!(status: 'prepared')
      rescue StandardError => exception
        context.fail!(message: exception.message)
      end
    end
  end
end
