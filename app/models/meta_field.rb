class MetaField < ApplicationRecord
  has_attached_file :og_image

  validates_attachment :og_image, :content_type => {
    :content_type => ['image/jpeg', 'image/jpg', 'image/png'],
    :message => 'Изображение должно быть в формате jpeg, jpg или png'
  }
end
