class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.belongs_to :organization
      t.string     :title
      t.string     :href

      t.timestamps
    end
  end
end
