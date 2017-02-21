module ApplicationHelper
  def collection_for_filter(kind)
    case kind.to_sym
    when :string
      []
    when :limited_list
      [:select, :check_boxes, :radio_buttons]
    when :unlimited_list
      [:select, :check_boxes, :radio_buttons]
    when :hierarch_limited_list
      []
    when :integer
      []
    when :float
      []
    when :boolean
      [:boolean]
    end
  end
end
