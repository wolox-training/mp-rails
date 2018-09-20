# class RentPolicy
#   class Scope
#     attr_reader :user, :scope

#     def initialize(user, scope)
#       @user = user
#       @scope = scope
#     end

#     def resolve
#       scope.where(user: user)
#     end

#     def show?
#       true
#     end

#     def index?
#       true
#     end
#   end
# end

class RentPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    user.id == record.user_id
  end
end
