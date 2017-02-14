class CreateCategoryProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :category_properties do |t|
      t.belongs_to :category
      t.belongs_to :property
      t.string :kind
      t.string :title
      t.integer :row_order
      t.boolean :necessarily

      t.timestamps
    end
  end
end
