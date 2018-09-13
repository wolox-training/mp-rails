class RentPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user: user)
    end

    def show?
      true
    end

    def index?
      true
    end
  end
end
