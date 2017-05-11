class Manage::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'manage'

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, flash: { denied: 'Недостаточно прав для выполнения операции' }
  end

  def current_city
    @current_city ||= MainCities.instance.find_by(:slug, params['city_slug'])
  end

  private

  def namespace
    @current_namespace ||= controller_path.split('/').first.capitalize
  end

  def current_ability
    current_city
    @current_ability ||= Ability.new(current_user, namespace)
  end
end
