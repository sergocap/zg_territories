class ListItem < ApplicationRecord
  belongs_to :property

  has_many :list_item_values
  has_many :values, through: :list_item_values

  validates :title, uniqueness: { scope: :property_id }

  alias_attribute :to_s, :title
end
