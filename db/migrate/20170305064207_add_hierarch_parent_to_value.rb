class AddHierarchParentToValue < ActiveRecord::Migration[5.0]
  def change
    add_column :values, :root_hierarch_list_item_id, :integer
  end
end
