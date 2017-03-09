class AddPhoneAndEmailToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :email, :string
    add_column :organizations, :phone, :string
  end
end
