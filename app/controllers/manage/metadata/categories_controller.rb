class Manage::Metadata::CategoriesController < ApplicationController
  before_action :find_category, only: [:destroy, :edit, :update]
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

  def edit
    render partial: 'form', locals: {category: @category} and return
  end

  def update
    if @category.update(category_params)
      render partial: 'category_item', locals: {category: @category} and return
    end
  end

  def destroy
    @category.destroy
    render nothing: true
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :ancestry)
  end
end
