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

  def update?
    @user&.is_admin || false
  end

  def admin_show_orders?
    @user&.is_admin || false
  end
end
