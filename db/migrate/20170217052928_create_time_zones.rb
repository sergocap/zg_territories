class CreateTimeZones < ActiveRecord::Migration[5.0]
  def change
    create_table :time_zones do |t|
      t.string :info

      t.timestamps
    end
  end
end
