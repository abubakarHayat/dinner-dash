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

  def create?
    @user&.is_admin || false
  end

  def show?
    true
  end

  def destroy?
    @user&.is_admin || false
  end

  def admin_show_restaurants?
    @user&.is_admin || false
  end
end
