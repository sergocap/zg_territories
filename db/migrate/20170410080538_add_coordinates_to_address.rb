class AddCoordinatesToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :area_coordinates, :string
  end
end
