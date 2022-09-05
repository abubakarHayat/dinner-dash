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

  def destroy?
    @user.present? && @user.admin?
  end

  alias_method :create?, :destroy?
end
