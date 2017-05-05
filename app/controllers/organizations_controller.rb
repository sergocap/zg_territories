class OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  before_action :find_category
  layout :resolve_layout

  def welcome
    if result_slug = current_user.try(:main_city_slug)
    else
      city_id = ApiWithProfile.main_city_id_by_ip(request.remote_ip)['id']
      city = MainCities.instance.find_by :id, city_id
      result_slug = city.slug
    end

    redirect_to organizations_path(city_slug: result_slug)
    @cities = MainCities.instance.all
  end

  def index
    @organizations = Searchers::OrganizationSearcher.new(search_params).search
  end

  def show
    unless current_user.present? && current_user.has_permission?(role: 'admin')
      redirect_to '/404' if !@organization.published? && !@organization.owner?(current_user)
    end
    @organization.add_statistic
  end

  def show_phone
    @organization = Organization.find(params[:organization_id])
    @organization.add_statistic('phone')
    render text: @organization.phone
  end

  def service_packs
    infos = ServicePack.all.map {|pack|
      osp = pack.organization_service_packs.where(:organization_id => params[:organization_id]).first
      {
        id: pack.id,
        paymented: osp.present?
      }
    }
    render json: { service_packs: ServicePack.all, infos: infos }, status: 200
  end

  private

  def resolve_layout
    case action_name
    when 'index'
      'map'
    when 'show'
      false
    else
      'application'
    end
  end

  def find_category
    @category = Category.find(params[:category]) if params[:category]
  end

  def search_params
    param_lists = params['list_items'] || []

    unless params['ranges'].nil?
      elems = []
      params['ranges'].each do |k, v|
        values = v.split(',').map(&:to_i)
        elems << list_items_between(values, k) if values.count == 2
      end
      param_lists << elems
    end

    unless params['ranges_select'].nil?
      elems = []
      params['ranges_select'].each do |k, v|
        values = []
        values[0] = v[0].empty? ?
          @category.properties.find(k).list_items.first.title.to_i :
          ListItem.find(v[0]).title.to_i

        values[1] = v[1].empty? ?
          @category.properties.find(k).list_items.last.title.to_i :
          ListItem.find(v[1]).title.to_i

        values.sort!
        elems << list_items_between(values, k) if values.count == 2
      end
      param_lists << elems
    end

    params_ranges = {}
    unless params['ranges_for_numeric'].nil?
      params['ranges_for_numeric'].each do |k, v|
        params_ranges[k.to_i] = v.split(',').map(&:to_f)
      end
    end

    params_booleans = {}
    unless params['boolean_values'].nil?
      params['boolean_values'].each do |k, v|
        params_booleans[k.to_i] = (v.to_i.zero? ? false : true)
      end
    end

    param_lists = param_lists.flatten

    {
      list_items: param_lists,
      hierarch_list_items: params[:hierarch_list_items],
      ranges_for_numeric: params_ranges,
      booleans: params_booleans,
      category_id: @category.try(:id),
      page: params[:page],
      city_id: current_city.try(:id),
      text: params[:text],
      state: 'published'
    }
  end

  def list_items_between(values, property_id)
    property = @category.properties.find(property_id)
    property.list_items
      .select {|item| (values[0]..values[1]).include?(item.title.to_i) }
      .map(&:id).map(&:to_s)

  end
end
