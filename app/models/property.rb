class Property < ApplicationRecord
  has_many :category_properties, dependent: :destroy
  has_many :categories, through: :category_properties
end
