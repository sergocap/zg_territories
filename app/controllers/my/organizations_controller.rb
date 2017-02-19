class My::OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  def show
     show! do |format|
       format.html { redirect_to organization_path(@organization) }
     end
  end

  def create
    create! { organization_path(@organization) }
  end

  private

  def organization_params
    params.require(:organization).permit(
      [:user_id, :title, :city_id, :address])
  end
end
