class Ability
  include CanCan::Ability

  def initialize user

    return unless user && user.admin?
    can :access, :rails_admin
    can :read, :dashboard
    can %i(show read destroy new), User
  end
end
