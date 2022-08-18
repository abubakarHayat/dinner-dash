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
    @user.is_admin
  end

  def edit?
    update?
  end

  def show?
    @user.is_admin
  end

  def update?
    @user.is_admin
  end

  def destroy?
    @user.is_admin
  end

  def admin_show_items?
    @user.is_admin
  end

end
