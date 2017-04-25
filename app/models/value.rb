class Value < ApplicationRecord
  belongs_to :property
  belongs_to :list_item
  belongs_to :hierarch_list_item
  belongs_to :organization
  has_many :list_item_values, dependent: :destroy
  has_many :list_items, through: :list_item_values

  def displayed?
    category_property.show_on_public
  end

  def category_property
    CategoryProperty.where(:property_id => property.id,
                           :category_id => organization.category.id).first
  end

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
    when :boolean
      boolean_value ? 'Есть' : 'Нет'
    when :string
      case category_property.show_as
      when 'string'
        string_value
      when 'link'
        "<a target='blank' href=\"#{string_value}\">#{string_value.truncate(50)}</a>".html_safe
      end
    when :float
      float_value
    when :integer
      integer_value
    when :limited_list
      list_item
    when :unlimited_list
      list_items.map(&:title).join('; ')
    when :hierarch_limited_list
      return nil unless hierarch_list_item.present?
      [hierarch_list_item.parent.title, hierarch_list_item.title].join(' - ')
    else
      ''
    end
  end

  def pretty_view
    case property.kind.to_sym
    when :boolean
      '{"property_id":"' + property.id.to_s + '","boolean_value":"' + (boolean_value ? 'on' : '') + '"}'
    when :string
      '{"property_id":"' + property.id.to_s + '","string_value":"' + string_value.to_s + '"}'
    when :float
      '{"property_id":"' + property.id.to_s + '","float_value":"' + float_value.to_s + '"}'
    when :integer
      '{"property_id":"' + property.id.to_s + '","integer_value":"' + integer_value.to_s + '"}'
    when :limited_list
      '{"property_id":"' + property.id.to_s + '","list_item_id":"' + list_item_id.to_s + '"}'
    when :unlimited_list
      '{"property_id":"' + property.id.to_s + '","list_item_ids":[' + list_items.map(&:id).map(&:to_s).join(',') + ']}'
    when :hierarch_limited_list
      '{"property_id":"' + property.id.to_s + '","root_hierarch_list_item_id":"' + root_hierarch_list_item_id.to_s + '","hierarch_list_item_id":"' + hierarch_list_item_id.to_s + '"}'
    when :root_hierarch_limited_list
      '{"property_id":"' + property.id.to_s + '","root_hierarch_list_item_id":"' + root_hierarch_list_item_id.to_s + '"}'
    else
      ''
    end
  end
end
