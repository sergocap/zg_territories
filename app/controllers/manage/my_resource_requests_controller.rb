class Manage::MyResourceRequestsController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources
  before_action :find_resources, only: [:show, :allow, :disallow]

  def allow
    @organization.update_attribute(:user_id, @user.id)
    resource.update_attribute(:status, 'allow')
    ApiWithProfile.send_mail_about_resource_request_state(@user, @organization, resource)
    redirect_to manage_my_resource_requests_path
  end

  def disallow
    resource.update_attribute(:status, 'disallow')
    ApiWithProfile.send_mail_about_resource_request_state(@user, @organization, resource)
    redirect_to manage_my_resource_requests_path
  end

  private
  def find_resources
    @organization = @my_resource_request.organization
    @user = @my_resource_request.user
  end
end
