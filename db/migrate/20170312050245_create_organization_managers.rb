class CreateOrganizationManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :organization_managers do |t|
      t.belongs_to  :organization
      t.uuid        :user_id, index: true
      t.string      :state

      t.timestamps
    end
  end
end
