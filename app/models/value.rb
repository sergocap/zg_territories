class Value < ApplicationRecord
  attr_accessor :hierarch_list_item_parent_id
  belongs_to :property
  belongs_to :list_item
  belongs_to :hierarch_list_item
  belongs_to :organization
  has_many :list_item_values, dependent: :destroy
  has_many :list_items, through: :list_item_values


  def get
    case property.kind.to_sym
    when :string
      string_value
    when :float
      float_value
    when :integer
      integer_value
    when :limited_list
      list_item
    when :unlimited_list
      list_items
    when :hierarch_limited_list
      hierarch_list_item
    else
      ''
    end
  end
end
