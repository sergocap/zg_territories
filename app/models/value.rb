class Value < ApplicationRecord
  attr_accessor :hierarch_list_item_parent_id
  belongs_to :property
  belongs_to :list_item
  belongs_to :hierarch_list_item
  belongs_to :organization
  has_many :list_item_values, dependent: :destroy
  has_many :list_items, through: :list_item_values


  searchable do
    integer :list_item_ids, multiple: true do
      (list_items.map(&:id) + [] << list_item_id).flatten.compact
    end

    integer :hierarch_list_item_ids, multiple: true do
      [hierarch_list_item_id].compact
    end

    integer :property_id

    double :numeric_values, multiple: true do
      ([integer_value] + [float_value]).compact
    end

    text    :string_value
    boolean :boolean_value

    integer :category_id do
      organization.category.id
    end

    integer :city_id do
      organization.city_id
    end

    string  :state do
      organization.state
    end

    text    :title do
      organization.title
    end
  end

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
