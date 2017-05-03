class RemoveOfficeFromAddress < ActiveRecord::Migration[5.0]
  def change
    remove_columns :addresses, :office, :region, :city_id, :street, :house
  end
end
