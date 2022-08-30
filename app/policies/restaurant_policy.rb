# frozen_string_literal: true

class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    create?
  end

  def show?
    true
  end

  def admin_show_restaurants?
    @user.admin?
  end

  alias_method :create?, :admin_show_restaurants?
  alias_method :destroy?, :admin_show_restaurants?
end
