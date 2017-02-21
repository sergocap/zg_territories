class My::OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  before_action :find_categories, only: :new

  def show
     show! do |format|
       format.html { redirect_to organization_path(@organization) }
     end
  end

  def create
    create! { organization_path(@organization) }
  end

  private

  def find_categories
    @categories = Category.roots
  end

  def organization_params
    params.require(:organization).permit(
      [:user_id, :category_id, :title, :city_id, :parent_id, :address,
         values_attributes: [:string_value, :integer_value, :float_value,
                           :property_id, :id,
                           :boolean_value,
                           :list_item_id,
                           :hierarch_list_item_id,
                           :category_id,
                           list_item_ids: []]
    ])

  end
end
