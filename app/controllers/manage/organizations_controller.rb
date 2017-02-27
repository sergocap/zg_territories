class Manage::OrganizationsController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources

  def index
    @organizations = Searchers::ManageOrganizationSearcher.new(search_params).collection
  end

  def change_state
    case params['new_state']
    when 'draft'
      @organization.to_draft
      ApiWithProfile::SendMail.organization_to_draft(@organization.user.id, @organization)
    when 'published'
      @organization.to_published
      ApiWithProfile::SendMail.organization_to_public(@organization.user.id, @organization)
    end

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
