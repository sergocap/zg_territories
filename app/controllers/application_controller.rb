class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, flash: { denied: 'Недостаточно прав для выполнения операции' }
  end

  private

  def namespace
    @current_namespace ||= controller_path.split('/').first.capitalize
  end

  def current_city
    @current_city ||= MainCities.instance.find_by(:slug, params['city_slug'])
  end

  def default_url_options options={}
    options.merge!(:city_slug => @current_city.slug) if @current_city.any?
    options
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace, current_city)
  end
end
