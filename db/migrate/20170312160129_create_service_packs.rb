class CreateServicePacks < ActiveRecord::Migration[5.0]
  def change
    create_table :service_packs do |t|
      t.string   :title
      t.string   :description
      t.string   :tag
      t.integer  :price_for_month
      t.integer  :price_for_six_months
      t.integer  :price_for_year
      t.boolean  :logotype
      t.boolean  :gallery
      t.boolean  :description_field
      t.boolean  :small_comment
      t.boolean  :price_list
      t.boolean  :brand

      t.timestamps
    end
  end
end
