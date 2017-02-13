class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string  :title
      t.string  :ancestry, index: true
      t.integer :ancestry_depth, default: 0

      t.timestamps
    end
  end
end
