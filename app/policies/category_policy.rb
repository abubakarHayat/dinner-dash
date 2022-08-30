# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
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

  def edit?
    update?
  end

  def admin_show_categories?
    @user.admin?
  end

  alias_method :create?, :admin_show_categories?
  alias_method :update?, :admin_show_categories?
  alias_method :destroy?, :admin_show_categories?
end
