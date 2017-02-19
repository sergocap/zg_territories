class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :title
      t.string :slug
      t.belongs_to :time_zone

      t.timestamps
    end
  end
end
