class RemovePhoneEmailFromOrganization < ActiveRecord::Migration[5.0]
  def change
    remove_columns :organizations, :phone, :email
  end
end
