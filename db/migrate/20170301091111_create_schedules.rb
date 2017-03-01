class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.boolean :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :default => false
      t.boolean :free, :default => false
      t.string  :comment
      t.time :from, :to
      t.belongs_to :organization
      t.timestamps
    end
  end
end
