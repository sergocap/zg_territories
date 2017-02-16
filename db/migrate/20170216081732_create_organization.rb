class CreateOrganization < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string  :title
      t.string  :address
      t.uuid    :user_id, index: true
      t.integer :parent_id
      t.belongs_to :category
    end
  end
end
