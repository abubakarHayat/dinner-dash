# frozen_string_literal: true

class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def admin_show_items?
    @user.admin?
  end

  alias_method :create?, :admin_show_items?
  alias_method :update?, :admin_show_items?
  alias_method :destroy?, :admin_show_items?
  alias_method :show?, :admin_show_items?
end
