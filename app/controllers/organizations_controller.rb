class OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  before_action :find_category

  def welcome
    @cities = City.all
  end

  def index
    @organizations = Searchers::OrganizationSearcher.new(search_params).collection
  end

  private

  def find_category
    @category = Category.find(params[:category]) if params[:category]
  end

  def search_params
    {
      list_items: params[:list_items],
      hierarch_list_items: params[:hierarch_list_items],
      category_id: @category.try(:id),
      page: params[:page],
      city_id: current_city.try(:id)
    }
  end
end
