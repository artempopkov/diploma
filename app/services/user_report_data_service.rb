class UserReportDataService
  def initialize(users)
    @users = users
  end

  def users_report
    report_data = Hash.new([])

    users.each do |user|
      history = UserHistoryService.new(user)
      report_data[user] = [history.likes_amount, history.views_amount, history.comments_amount]
    end
    report_data
  end

  private

  attr_reader :users
end
