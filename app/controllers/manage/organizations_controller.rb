class Manage::OrganizationsController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources

  def index
    @organizations = Searchers::ManageOrganizationSearcher.new(search_params).collection
  end

  def change_state
    new_state = params['new_state']
    message = params['message']
    @organization.send ("to_#{new_state}")
    ApiWithProfile::send_mail_about_state new_state, @organization, message

    respond_to do |format|
      format.js
    end
  end

  private

  def search_params
    {
      page: params[:page],
      state: params[:state],
      text: params[:text]
    }
  end
end
