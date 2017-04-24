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
      can [:show, :edit, :update, :statistics], Organization do |organization|
        organization.manager? user
      end

      ServicePack.service_list.each do |item|
        cannot item, Organization do |organization|
          !organization.can_service?(item)
        end
      end

      can :new, Organization
    else
      can :create, Payment
      can [:show, :index], Organization, :city_id => city.id if city
      can [:service_packs, :show_phone, :welcome], Organization
      can [:new, :create], MyResourceRequest if user.present?
    end
  end
end
