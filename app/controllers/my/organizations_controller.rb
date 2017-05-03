class My::OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources

  before_action :find_categories, only: [:new, :create]
  before_action :find_category,   only: [:edit]
  before_filter :build_nested_objects, :only => [:edit, :new, :create]

  def show
     show! do |format|
       format.html { redirect_to organization_path(@organization) }
     end
  end

  def index
    @organizations = Organization.where(user_id: current_user.id, city_id: @current_city.id).page(params[:page]).per(20)
  end

  def create
    create! do |format|
      format.html do
        if @organization.save
          redirect_to organization_path(@organization)
        else
          render :new
        end
      end
    end
  end

  def change_state
    case params['new_state']
    when 'draft'
      @organization.to_draft
    when 'moderation'
      @organization.to_moderation
    end

    respond_to do |format|
      format.js
    end
  end

  def managers_for_organization
    @organization = Organization.find(params[:id])
    managers = []
    @organization.organization_managers.map {|om|
      managers << { user: om.manager, organization_manager: om } }

    respond_to do |format|
      format.json { render json: { managers: managers } }
    end
  end

  private

  def find_categories
    @categories = Category.roots
  end

  def find_category
    @category = @organization.category
  end

  def organization_params
    params.require(:organization).permit(
      [:user_id, :description, :bootsy_image_gallery_id, :category_id, :logotype, :title, :city_id, :parent_id,
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
    @organization.phones.present? ||  @organization.phones.build
    @organization.emails.present? ||  @organization.emails.build
    @organization.links.present? ||    @organization.links.build
  end
end
