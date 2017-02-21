class Manage::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'manage'

  private

  def namespace
    @current_namespace ||= controller_path.split('/').first.capitalize
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end
end
