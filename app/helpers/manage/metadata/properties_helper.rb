module Manage::Metadata::PropertiesHelper
  def can_change_fields?(category, property)
    property.native_category == category
  end

  def literal?(kind)
    [:string, :integer, :float].include? kind.to_sym
  end
end

