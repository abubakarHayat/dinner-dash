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

  def create?
    @user&.is_admin || false
  end

  def edit?
    update?
  end

  def show?
    @user&.is_admin || false
  end

  def update?
    @user&.is_admin || false
  end

  def destroy?
    @user&.is_admin || false
  end

  def admin_show_items?
    @user&.is_admin || false
  end
end
