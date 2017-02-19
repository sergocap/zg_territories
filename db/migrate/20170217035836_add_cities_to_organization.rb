class AddCitiesToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :city_id, :integer, index: true
  end
end
