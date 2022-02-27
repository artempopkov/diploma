module Reports
  class CorrespondentsDataService
    CorrespondentsReportData = Struct.new(:correspondent, :articles_count, :likes, :views, :comments)

    def initialize(correspondents)
      @correspondents = correspondents
    end

    def correspondents_report
      report_data = []

      correspondents.each do |correspondent|
        articles = correspondent.articles

        likes_amount = 0
        views_amount = 0
        comments_amount = 0

        articles.each do |article|
          likes_amount += article.get_likes.size
          views_amount += article.impressions_count
          comments_amount += article.comments.count
        end

        report_data << CorrespondentsReportData.new(correspondent, articles.count, likes_amount, views_amount, comments_amount)
      end
      report_data
    end

    private

    attr_reader :correspondents
  end
end
