class CreateListItemValues < ActiveRecord::Migration[5.0]
  def change
    create_table :list_item_values do |t|
      t.belongs_to :heirarch_list_item
      t.belongs_to :list_item
      t.belongs_to :value

      t.timestamps
    end
  end
end
