class OrganizationManagersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user_id = ApiWithProfile::get_users_id_by(:email, params[:email]).first
    @organization_manager = OrganizationManager.new(user_id: user_id,
      organization_id: params[:organization_id])

    respond_to do |format|
      format.json {
        if @organization_manager.save
          @organization = Organization.find(params[:organization_id])
          @user = User.find_by id: user_id
          ApiWithProfile::send_mail_about_role(@user, @organization, @organization_manager)
          render :json => @user
        else
          render :json => { errors: @organization_manager.errors.messages }, status: 422
        end
      }
    end
  end

  def confirm_manager_role
    organization_manager = OrganizationManager.find(params[:id])
    organization_manager.update_attribute(:state, 'confirmed')
    redirect_to my_organization_path(organization_manager.organization_id, city_slug: organization_manager.organization.city.friendly_id)
  end
end
