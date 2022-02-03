class ApplicationPolicy
  attr_reader :moderator, :record

  def initialize(moderator, record)
    @moderator = moderator
    @record = record
  end

  def index?
    moderator.admin?
  end

  def show?
    moderator.admin?
  end

  def create?
    moderator.admin?
  end

  def new?
    create?
  end

  def update?
    moderator.admin?
  end

  def edit?
    update?
  end

  def destroy?
    moderator.admin?
  end

  class Scope
    def initialize(moderator, scope)
      @moderator = moderator
      @scope = scope
    end

    def resolve
      scope
    end

    private

    attr_reader :moderator, :scope
  end
end
