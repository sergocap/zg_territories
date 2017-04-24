class AddSlugToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :slug, :string, unique: true
  end
end
