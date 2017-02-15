class Property < ApplicationRecord
  belongs_to :native_category, class_name: 'Category', foreign_key: 'category_id'
  has_many :category_properties, dependent: :destroy
  has_many :categories, through: :category_properties
  has_many :values, dependent: :destroy
  has_many :list_items, dependent: :destroy
  has_many :hierarch_list_items, dependent: :destroy

  accepts_nested_attributes_for :category_properties, allow_destroy: true
  accepts_nested_attributes_for :list_items, allow_destroy: true
  accepts_nested_attributes_for :hierarch_list_items, allow_destroy: true

  extend Enumerize
  enumerize :kind, in: [:string, :integer, :float, :boolean, :limited_list, :unlimited_list, :hierarch_limited_list], default: :string
end
