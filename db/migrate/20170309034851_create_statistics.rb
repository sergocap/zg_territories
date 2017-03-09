class CreateStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :statistics do |t|
      t.belongs_to :organization
      t.string     :kind
      t.timestamps
    end
  end
end
