class My::OrganizationsController < ApplicationController
  inherit_resources
  authorize_resource

  def create
    create! { organization_path(@organization) }
  end

  def update
    update! { organization_path(@organization) }
  end

  private

  def organization_params
    params.require(:organization).permit(
      [:user_id, :title, :address])
  end
end
