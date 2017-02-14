class CategoryProperty < ApplicationRecord
  belongs_to :category
  belongs_to :property

  include RankedModel
  ranks :row_order, with_same: :category_id
  scope :by_position, -> { order('row_order') }
  default_scope { by_position }
end
