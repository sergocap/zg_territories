class Manage::ServicePacksController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources

  def create
    create! { manage_service_packs_path }
  end

  def update
    update! { manage_service_packs_path }
  end

  private

  def service_pack_params
    params.require(:service_pack).permit([:title, :description, :price_for_month,
                     :price_for_six_months, :price_for_year,
                     :tag, :logotype, :small_comment, :description_field,
                     :price_list, :gallery, :brand])
  end
end
