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

  def show
    redirect_to '/404' if !@organization.published? && !@organization.owner?(current_user)
  end

  private

  def find_category
    @category = Category.find(params[:category]) if params[:category]
  end

  def search_params
    param_lists = params['list_items'] || []

    unless params['ranges'].nil?
      elems = []
      params['ranges'].each do |k, v|
        values = v.split(',').map(&:to_i)
        elems << @category.properties.find(k.to_i)
          .list_items.select {|item| (values[0]..values[1]).include?(item.title.to_i) }
          .map(&:id).map(&:to_s) if values.size == 2
      end
      param_lists << elems
      param_lists = param_lists.flatten
    end

    {
      list_items: param_lists,
      hierarch_list_items: params[:hierarch_list_items],
      category_id: @category.try(:id),
      page: params[:page],
      city_id: current_city.try(:id),
      text: params[:text],
      state: 'published'
    }
  end
end
