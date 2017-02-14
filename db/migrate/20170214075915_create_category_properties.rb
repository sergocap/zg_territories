class CreateCategoryProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :category_properties do |t|
      t.belongs_to :category
      t.belongs_to :property
      t.integer    :row_order
      t.boolean    :necessarily, default: false
      t.boolean    :show_on_public, default: true
      t.string     :show_as, default: 'check_boxes'
      t.timestamps
    end
  end
end
