class My::OrganizationsController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  before_action :find_categories, only: [:new, :create]
  before_action :find_category,   only: [:edit]
  before_filter :build_nested_objects, :only => [:new, :create]

  def show
     show! do |format|
       format.html { redirect_to organization_path(@organization) }
     end
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

  private

  def find_categories
    @categories = Category.roots
  end

  def find_category
    @category = @organization.category
  end

  def organization_params
    params.require(:organization).permit(
      [:user_id, :category_id, :title, :city_id, :parent_id, :address,
         schedules_attributes: [:id, :from, :to, :monday, :tuesday,
                                :wednesday, :thursday, :friday,
                                :saturday, :sunday, :free,
                                :comment, :_destroy,
                                breaks_attributes: [:id, :from, :to, :_destroy]],
         values_attributes: [:string_value, :integer_value, :float_value,
                           :property_id, :id,
                           :boolean_value,
                           :list_item_id,
                           :hierarch_list_item_id,
                           :root_hierarch_list_item_id,
                           :category_id,
                           list_item_ids: []]
    ])

  end

  def build_nested_objects
    @organization.schedules.any? || @organization.schedules.build
  end
end
