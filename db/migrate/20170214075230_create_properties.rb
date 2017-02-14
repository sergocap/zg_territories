class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string  :kind
      t.string  :title
      t.integer :category_id
      t.string  :show_on_filter_as
      t.timestamps
    end
  end
end
