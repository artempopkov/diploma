module Admin
  class ReportsController < AdminController
    after_action :verify_authorized

    def users_report
      @users_report = Reports::UsersDataService.new(User.all).users_report
      authorize [:admin, :report], :users_report?

      respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=users_report.xlsx"
        }
      end
    rescue StandardError => e
      redirect_to admin_url, notice: 'Ошибка создания отчёта'
    end

    def correspondents_report
      @correspondents_report = Reports::CorrespondentsDataService.new(Moderator.correspondent).correspondents_report
      authorize [:admin, :report], :correspondents_report?

      respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=correspondents_report.xlsx"
        }
      end
    rescue StandardError => e
      redirect_to admin_url, notice: 'Ошибка создания отчёта'
    end

    def articles_report
      @articles_report = Reports::ArticlesDataService.new(Article.all).articles_report
      authorize [:admin, :report], :articles_report?

      respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=articles_report.xlsx"
        }
      end
      
    rescue StandardError => e
      redirect_to admin_url, notice: 'Ошибка создания отчёта'
    end
  end
end
