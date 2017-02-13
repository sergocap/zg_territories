class Category < ApplicationRecord
  has_ancestry cache_depth: true
  scope :ordered, -> {order('title')}
end
