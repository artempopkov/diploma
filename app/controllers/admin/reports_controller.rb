module Admin
  class ReportsController < AdminController

    def users_report
      @users_report = UserReportDataService.new(User.all).users_report

      respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=users_report.xlsx"
        }
      end
    end

    def correspondents_report
      @correspondents_report = CorrespondentReportDataService.new(Moderator.correspondent).correspondents_report
      
      respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=correspondents_report.xlsx"
        }
      end
    end
  end
end
