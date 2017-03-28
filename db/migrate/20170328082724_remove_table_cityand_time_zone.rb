class RemoveTableCityandTimeZone < ActiveRecord::Migration[5.0]
  def change
    drop_table :cities
    drop_table :time_zones
  end
end
