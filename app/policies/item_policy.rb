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

  def destroy?
    @user.admin?
  end

  alias_method :create?, :destroy?
  alias_method :update?, :destroy?
  alias_method :show?, :destroy?
end
