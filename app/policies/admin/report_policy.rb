module Admin
  class ReportPolicy < Struct.new(:moderator, :report)
    def users_report?
      moderator.admin?
    end

    def correspondents_report?
      moderator.admin?
    end

    def articles_report?
      moderator.admin?
    end
  end
end
