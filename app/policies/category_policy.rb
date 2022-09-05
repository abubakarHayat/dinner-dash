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

  def destroy?
    @user.present? && @user.admin?
  end

  alias_method :create?, :destroy?
  alias_method :update?, :destroy?
end
