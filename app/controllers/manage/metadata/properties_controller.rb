class Manage::Metadata::PropertiesController < ApplicationController
  before_action :find_category, only: [:new, :create]

  def new
    @property = Property.new property_params
    @category_property = @category.category_properties.new
  end

  def create
    @property = Property.create property_params
    @property.category_properties.create category_property_params
    redirect_to manage_metadata_category_path(@category)
  end

  private

  def find_category
    @category = Category.find(params[:category_id])
  end

  def property_params
    params.require(:property).permit(:title, :kind, :category_id, :show_on_filter_as,
      hierarch_list_items_attributes: [:id, :title, :_destroy],
      list_items_attributes: [:id, :title, :_destroy])
  end

  def category_property_params
    params.require(:property).require(:category_property).
      permit(:show_on_public, :show_as, :necessarily, :category_id)
  end
end
