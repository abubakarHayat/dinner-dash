# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def edit?
    update?
  end

  def admin_show_orders?
    @user.admin?
  end

  alias_method :update?, :admin_show_orders?
end
