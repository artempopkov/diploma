class ApplicationPolicy
  attr_reader :moderator, :record

  def initialize(moderator, record)
    @moderator = moderator
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(moderator, scope)
      @moderator = moderator
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :moderator, :scope
  end
end
