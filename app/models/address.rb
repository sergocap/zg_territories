class Address < ApplicationRecord
  belongs_to :organization

  validates_presence_of :street, :house

  def to_s
    return "" if street.blank? && house.blank?
    return "#{street.squish}" if house.blank?
    return "#{street.squish}, #{house.squish}"
  end

  def pretty_area_coordinates
    json_decode = JSON.parse(area_coordinates)
    json_decode.map {|ob| [ob['y'], ob['x']] }
  end
end
