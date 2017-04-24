class CreateMetaFields < ActiveRecord::Migration[5.0]
  def change
    create_table :meta_fields do |t|
      t.text       :path
      t.text       :title
      t.text       :header
      t.text       :keywords
      t.text       :description
      t.text       :introduction
      t.text       :og_title
      t.text       :og_description
      t.attachment :og_image

      t.timestamps
    end
  end
end
