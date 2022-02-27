module Reports
  class ArticlesDataService
    ArticlesReportData = Struct.new(:article, :likes, :views, :comments)

    def initialize(articles)
      @articles = articles
    end

    def articles_report
      report_data = []

      articles.each do |article|
        report_data << ArticlesReportData.new(article, article.get_likes.size, article.impressions_count, article.comments.count)
      end
      report_data
    end

    private

    attr_reader :articles
  end
end
