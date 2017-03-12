class Manage::Metadata::CategoriesController < Manage::ApplicationController
  load_resource only: :show

  before_action :find_category, only: [:destroy, :edit, :update, :parent_params]

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
      render partial: 'category_item', locals: {category: @category} and return if request.xhr?
      redirect_to manage_metadata_category_path(@category)
    end
  end

  def destroy
    @category.destroy
    render nothing: true
  end

  def parent_params
    @parent_properties = @category.ancestors.map(&:properties).flatten.uniq
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :ancestry, property_ids: [])
  end
end
