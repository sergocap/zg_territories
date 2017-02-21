class OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  def welcome
    @cities = City.all
  end

  def index
    if params[:category]
      if params['commit'] == 'Фильтровать'
        #raise params.inspect
      else
        @category = Category.find(params[:category])
        @organizations = @category.organizations.page(params[:page]).per 10
      end
    else
      @organizations = Organization.all.page(params[:page]).per 10
    end
  end
end
