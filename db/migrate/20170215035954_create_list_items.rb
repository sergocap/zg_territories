class CreateListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :list_items do |t|
      t.string :title
      t.belongs_to :property

      t.timestamps
    end
  end
end
