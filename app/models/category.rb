class Category < ApplicationRecord
  has_many :category_properties, dependent: :destroy
  has_many :properties, through: :category_properties

  has_ancestry cache_depth: true
  scope :ordered, -> {order('title')}
end
