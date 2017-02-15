class HierarchListItem < ApplicationRecord
  belongs_to :property
  has_many :list_item_values
  has_many :values, through: :list_item_values
  has_many :children, class_name: 'HierarchListItem', foreign_key: 'parent_id', dependent: :destroy
  validates :title, uniqueness: { scope: :property_id }

  accepts_nested_attributes_for :children, allow_destroy: true
end
