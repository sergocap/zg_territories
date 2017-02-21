class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def namespace
    @current_namespace ||= controller_path.split('/').first.capitalize
  end

  def current_city
    @current_city ||= City.where(slug: params['city_slug']).first
  end

  def default_url_options options={}
    options.merge!(:city_slug => @current_city.friendly_id) if @current_city
    options
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace, current_city)
  end
end
