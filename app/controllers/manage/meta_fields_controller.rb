class Manage::MetaFieldsController < Manage::ApplicationController
  load_and_authorize_resource
  inherit_resources

  private
  def meta_field_params
    params.require(:meta_field).permit([:path, :description, :header,
                                       :introduction, :keywords, :og_description,
                                       :og_title, :title, :og_image])
  end
end
