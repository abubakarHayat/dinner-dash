class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    @user.present? && @user.admin?
  end

  alias_method :show_orders?, :index?
  alias_method :show_categories?, :index?
  alias_method :show_restaurants?, :index?
  alias_method :show_items?, :index?
end
