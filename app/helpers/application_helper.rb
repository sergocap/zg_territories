module ApplicationHelper
  def collection_for_filter(kind)
    {
      'string' => [],
      'limited_list' => [:range, :range_select, :range_buttons, :select, :check_boxes, :radio_buttons],
      'unlimited_list' => [:range, :range_select, :range_buttons, :select, :check_boxes, :radio_buttons],
      'hierarch_limited_list' => [:hierach_limited_list],
      'integer' => [:range, :range_select, :range_buttons],
      'float' => [:range, :range_select],
      'boolean' => [:boolean]
    }[kind]
  end

  def collection_for_show_as(kind)
    {
      'string' => [:string],
      'limited_list' => [:radio_buttons, :select],
      'unlimited_list' => [:check_boxes],
      'hierarch_limited_list' => [:hierach_limited_list],
      'integer' => [:numeric],
      'float' => [:numeric],
      'boolean' => [:boolean]
    }[kind]
  end

  def massive(property)
    property.list_items.map(&:title).map(&:to_i).delete_if {|x| x == 0}
  end

  def min_value(property)
    massive(property).min
  end

  def max_value(property)
    massive(property).max
  end

  def ticks_value(property)
    massive(property).sort
  end

  def value(property, params_ranges)
    if value = params_ranges.try(:[], property.id.to_s)
      value.split(',').map(&:to_i)
    else
      return [min_value(property),max_value(property)]
    end
  end

  def selected_for_ranges_select(params_ranges_select, property, position)
    if !params_ranges_select.try(:[], "#{property.id.to_s}").nil?
      params_ranges_select[property.id.to_s][position == 'first' ? 0 : 1]
    end
  end
end
