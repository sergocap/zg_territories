class CreateHierarchListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :hierarch_list_items do |t|
      t.string     :title
      t.string     :ancestry
      t.belongs_to :property

      t.timestamps
    end
  end
end
