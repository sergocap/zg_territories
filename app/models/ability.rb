class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace, city = nil)
    case controller_namespace
    when 'Manage'
      return unless user
      can :manage, :all if user.has_permission?(role: 'admin')
    when 'My'
      return unless user
      can :manage, Organization, :user_id => user.id
      can :new, Organization
    end

    can :read, Organization, :city_id => city.id if city
    can :read, Organization unless city
    can :welcome, Organization
  end
end
