class CreateGalleryImages < ActiveRecord::Migration[5.0]
  def change
    create_table :gallery_images do |t|
      t.attachment :element
      t.string     :description
      t.belongs_to :organization

      t.timestamps
    end
  end
end
