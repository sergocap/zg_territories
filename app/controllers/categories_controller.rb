class CategoriesController < ApplicationController
  def get_by_id
    @category = Category.find(params[:id])
    respond_to do |format|
      format.json do
        render json: {
                      category: @category,
                      properties: @category.properties,
                      category_properties: @category.category_properties,
                      list_items: @category.properties.map(&:list_items).flatten,
                      root_hierarch_list_items: @category.properties.map(&:hierarch_list_items).flatten
        }
      end
    end
  end

  def get_hierarch_list_items
    @parent = HierarchListItem.find(params[:id])
    respond_to do |format|
      format.json do
        render json: { hierarch_list_items: @parent.children }
      end
    end
  end
end
