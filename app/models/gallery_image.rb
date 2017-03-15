class GalleryImage < ApplicationRecord
  belongs_to :organization
  has_attached_file :element, styles: { medium: "300x300>", thumb: "100x100>"  }, default_url: "/images/missing.jpg"
  validates_attachment_content_type :element, content_type: /\Aimage\/.*\z/
end
