module Reports
  class UsersDataService
    UsersReportData = Struct.new(:user, :likes, :views, :comments)

    def initialize(users)
      @users = users
    end

    def users_report
      report_data = []

      users.each do |user|
        history = UserHistoryService.new(user)
        report_data << UsersReportData.new(user, history.likes_amount, history.views_amount, history.comments_amount)
      end
      report_data
    end

    private

    attr_reader :users
  end
end
