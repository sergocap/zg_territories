module ApplicationHelper
  def meta_field
    @meta_field ||= MetaField.where(path: request.path).first
  end

  def meta_field_item(item)
    content = meta_field.try(:send, item) || Settings['meta_field'][item]
    "<meta name='#{ item }' content='#{ content }' />".html_safe
  end

  def meta_title
    content = meta_field.try(:title) || Settings['meta_field']['title']
    "<title>#{ content }</title>".html_safe
  end

  def og_meta_field_item(item)
    content = meta_field.try(:send, "og_#{ item }") || Settings['og_meta_field'][item]
    "<meta property='og:#{ item }' content='#{ content }' />".html_safe
  end

  def collection_for_filter(kind)
    {
      'string' => [],
      'limited_list' => [:range, :range_select, :range_buttons, :select, :check_boxes, :radio_buttons],
      'unlimited_list' => [:range, :range_select, :range_buttons, :select, :check_boxes, :radio_buttons],
      'hierarch_limited_list' => [:hierarch_limited_list],
      'integer' => [:range_for_numeric],
      'float' => [:range_for_numeric],
      'boolean' => [:boolean]
    }[kind]
  end

  def collection_for_show_as(kind)
    {
      'string' => [:string, :link],
      'limited_list' => [:radio_buttons, :select],
      'unlimited_list' => [:check_boxes],
      'hierarch_limited_list' => [:hierarch_limited_list],
      'integer' => [:numeric],
      'float' => [:numeric],
      'boolean' => [:boolean]
    }[kind]
  end

  def category_property(category_id, property_id)
    CategoryProperty.where(:category_id => category_id, :property_id => property_id).first
  end

  def massive(property)
    property.list_items.map(&:title).map(&:to_i).delete_if {|x| x == 0}
  end

  def massive_num(property)
    (property.values.map(&:integer_value).to_a.compact + property.values.map(&:float_value).to_a.compact).sort
  end

  def value(property, params_ranges)
    if values = params_ranges.try(:[], property.id.to_s)
      values.split(',').map(&:to_i)
    else
      return [massive(property).min, massive(property).max]
    end
  end

  def value_num(property, params_ranges_numeric)
    if values = params_ranges_numeric.try(:[], property.id.to_s)
      values.split(',').map(&:to_i)
    else
      return [massive_num(property).min, massive_num(property).max]
    end
  end

  def selected_for_ranges_select(params_ranges_select, property, position)
    if values = params_ranges_select.try(:[], property.id.to_s)
      values[position == 'first' ? 0 : 1]
    end
  end
end
