class City < ApplicationRecord
  extend FriendlyId
  belongs_to :time_zone
  has_many :organizations
  friendly_id :title, use: [:slugged, :finders]
  alias_attribute :to_s, :title
end
