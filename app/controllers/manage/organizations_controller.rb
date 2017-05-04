class Manage::OrganizationsController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources
  before_action :find_category,   only: [:edit]
  before_filter :build_nested_objects, :only => [:edit]

  def index
    @organizations = Searchers::ManageOrganizationSearcher.new(search_params).search
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

  def show
     show! do |format|
       format.html { redirect_to organization_path(@organization, city_slug: @organization.city.slug) }
     end
  end

  def update
    update! { organization_path(@organization, city_slug: @organization.city.slug) }
  end

  private
  def find_category
    @category = @organization.category
  end

  def organization_params
    params.require(:organization).permit(
      [:description, :bootsy_image_gallery_id, :category_id, :logotype, :title, :city_id, :parent_id,
         values_attributes: [:string_value, :integer_value, :float_value,
                           :property_id, :id,
                           :boolean_value,
                           :list_item_id,
                           :hierarch_list_item_id,
                           :root_hierarch_list_item_id,
                           :category_id,
                           list_item_ids: []],
         address_attributes: [:area_coordinates, :longitude, :latitude],
         phones_attributes: [:value, :id, :_destroy],
         emails_attributes: [:value, :id, :_destroy],
         links_attributes: [:title, :href, :id, :_destroy],
         gallery_images_attributes: [:element, :description, :_destroy, :id],
    ])
  end

  def build_nested_objects
    @organization.address.present? || @organization.build_address
  end

  def search_params
    {
      page: params[:page],
      state: params[:state],
      text: params[:text]
    }
  end
end
