module Manage::Metadata::PropertiesHelper
  def can_change_fields?(category, property)
    property.native_category == category
  end

  def literal?(kind)
    [:string, :integer, :float].include? kind.to_sym
  end

  def collection_for_filter(kind)
    case kind.to_sym
    when :string
      []
    when :limited_list
      [:select, :check_boxes, :range, :multiselect, :radio_buttons, :boolean, :range_buttons, :range_select]
    when :unlimited_list
      [:select, :check_boxes, :range, :multiselect, :radio_buttons, :boolean, :range_buttons, :range_select]
    when :hierarch_limited_list
      [:boolean]
    when :integer
      [:check_boxes, :range, :range_buttons, :range_select]
    when :float
      [:check_boxes, :range, :range_buttons, :range_select]
    when :boolean
      [:boolean]
    end
  end
end

