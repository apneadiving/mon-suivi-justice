class AppointmentTypePolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def show?
    user.admin?
  end

  def new_first?
    user.admin?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end