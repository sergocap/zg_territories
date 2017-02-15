class CreateValues < ActiveRecord::Migration[5.0]
  def change
    create_table :values do |t|
      t.belongs_to  :organization, index: true
      t.belongs_to  :property, index: true
      t.belongs_to  :list_item
      t.belongs_to  :hierarch_list_item
      t.string      :string_value
      t.integer     :integer_value
      t.float       :float_value
      t.boolean     :boolean_value
      t.timestamps
    end
  end
end
