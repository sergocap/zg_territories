class Manage::OrganizationsController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources

  def index
    @organizations = Searchers::ManageOrganizationSearcher.new(search_params).collection
  end

  private

  def search_params
    {
      page: params[:page],
      state: params[:state]
    }
  end
end
