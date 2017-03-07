class RemoveAddressFromOrganization < ActiveRecord::Migration[5.0]
  def change
    remove_column :organizations, :address
  end
end
