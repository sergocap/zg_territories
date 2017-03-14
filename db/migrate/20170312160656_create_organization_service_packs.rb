class CreateOrganizationServicePacks < ActiveRecord::Migration[5.0]
  def change
    create_table :organization_service_packs do |t|
      t.belongs_to  :organization
      t.belongs_to  :service_pack
      t.integer     :duration
      t.float       :price

      t.timestamps
    end
  end
end
