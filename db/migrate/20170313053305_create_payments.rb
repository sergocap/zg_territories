class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :paymentable, polymorphic: true
      t.belongs_to :organization
      t.string     :state
      t.float      :amount
      t.string     :details
      t.uuid       :user_id

      t.timestamps
    end
  end
end
