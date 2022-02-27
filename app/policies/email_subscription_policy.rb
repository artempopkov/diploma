module Admin
  class EmailSubscriptionPolicy < Struct.new(:moderator, :report)
    def index?
      true
    end

    def correspondents_report?
      moderator.admin?
    end

    def articles_report?
      moderator.admin?
    end

    class Scope < Scope
      def resolve
        scope.where(moderator_id: moderator.id)
      end
    end
  end
end
