class OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  def welcome
    @cities = City.all
  end
end
