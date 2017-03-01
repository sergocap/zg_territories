class AddDefaultToBooleanValue < ActiveRecord::Migration[5.0]
  def change
    change_column :values, :boolean_value, :boolean, :default => false
  end
end
