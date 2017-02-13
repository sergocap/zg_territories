class Manage::Metadata::CategoriesController < ApplicationController
  def index
    @categories = Category.roots.ordered
  end

  def new
    @category = Category.new
    render partial: 'form'  and return
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render partial: 'children',
        locals: {children: @category.ancestry ?
                 @category.parent.children :
                 Category.roots.ordered} and return
    end
  end

  private
  def category_params
    params.require(:category).permit(:title, :ancestry)
  end
end
