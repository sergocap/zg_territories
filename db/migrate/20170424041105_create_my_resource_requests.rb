class CreateMyResourceRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :my_resource_requests do |t|
      t.uuid        :user_id
      t.string      :phone
      t.string      :email
      t.belongs_to  :organization
      t.string      :status
      t.timestamps
    end
  end
end
