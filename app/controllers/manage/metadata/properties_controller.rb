class Manage::Metadata::PropertiesController < ApplicationController
  before_action :find_category, only: [:new, :create, :destroy, :edit, :update]
  before_action :find_property, only: [:destroy, :edit, :update]
  before_action :find_category_property, only: [:destroy, :edit, :update]

  def new
    @property = Property.new property_params
    @category_property = @category.category_properties.new
  end

  def create
    @property = Property.create property_params
    @property.category_properties.create category_property_params
    resolve_redirect
  end

  def destroy
    @category_property.destroy
    @property.destroy if @property.category_properties.count.zero?
    redirect_to manage_metadata_category_path(@category)
  end

  def update
    @property.update property_params
    @category_property.update category_property_params
    resolve_redirect
  end

  private

  def find_category
    @category = Category.find(params[:category_id])
  end

  def find_property
    @property = Property.find(params[:id])
  end

  def find_category_property
    @category_property = @category.category_properties.where(:property_id => @property.id).first
  end

  def property_params
    params.require(:property).permit(:title, :kind, :category_id, :show_on_filter_as,
      hierarch_list_items_attributes: [:id, :title, :_destroy, children_attributes: [:id, :title, :_destroy]],
      list_items_attributes: [:id, :title, :_destroy])
  end

  def category_property_params
    params.require(:property).require(:category_property).
      permit(:show_on_public, :show_as, :necessarily, :category_id)
  end

  def resolve_redirect
    unless params['save_and_return']
      redirect_to manage_metadata_category_path(@category)
    else
      redirect_to edit_manage_metadata_category_property_path(@category, @property)
    end
  end
end
