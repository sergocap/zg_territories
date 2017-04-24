class MyResourceRequestsController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  before_action :find_organization

  def create
    create! { organization_path(@organization) }
  end

  private
  def find_organization
    @organization = Organization.find(params[:organization_id])
  end

  def my_resource_request_params
    params.require(:my_resource_request).permit([:user_id, :organization_id, :phone, :email])
  end
end

