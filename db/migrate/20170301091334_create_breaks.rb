class CreateBreaks < ActiveRecord::Migration[5.0]
  def change
    create_table :breaks do |t|
      t.time :from, :to
      t.belongs_to :schedule

      t.timestamps
    end
  end
end
