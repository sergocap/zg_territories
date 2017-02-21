class OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  def welcome
    @cities = City.all
  end

  def index
    @organizations = Organization.all.page(params[:page]).per 10
  end
end
