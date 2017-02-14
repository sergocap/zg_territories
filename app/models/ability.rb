class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    case controller_namespace
    when 'Manage'
      return unless user
      can :manage, :all if user.has_permission?(role: 'admin')
    end
  end
end
