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
          render :json => { user: @user, organization_manager: @organization_manager }
        else
          render :json => { errors: @organization_manager.errors.messages }, status: 422
        end
      }
    end
  end

  def transfer_main_role
    organization_manager = OrganizationManager.find(params[:id])
    @organization = organization_manager.organization
    user = organization_manager.manager
    old_user = @organization.user
    @organization.update_attribute(:user_id, organization_manager.user_id)
    ApiWithProfile::send_mail_about_main_role(user, @organization)
    organization_manager.destroy
    OrganizationManager.create(state: 'confirm',
                               user_id: old_user.id,
                               organization_id: @organization.id)
    redirect_to organization_path(@organization, city_slug: @organization.city.friendly_id)
  end

  def destroy
    organization_manager = OrganizationManager.find(params[:id])
    organization_manager.destroy
    render :json => {}, status: 200
  end

  def confirm_manager_role
    organization_manager = OrganizationManager.find(params[:id])
    organization_manager.update_attribute(:state, 'confirmed')
    redirect_to organization_path(organization_manager.organization_id, city_slug: organization_manager.organization.city.friendly_id)
  end
end
