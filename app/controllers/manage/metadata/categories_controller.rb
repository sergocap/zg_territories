class Manage::Metadata::CategoriesController < ApplicationController
  def index
    @categories = Category.roots.ordered
  end

  def new
    @category = Category.new
    render partial: 'form' and return
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to manage_metadata_categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit(:title)
  end
end
