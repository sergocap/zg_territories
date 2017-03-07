class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :city_id
      t.string  :street, :house, :region, :office, :longitude, :latitude
      t.belongs_to :organization

      t.timestamps
    end
  end
end
