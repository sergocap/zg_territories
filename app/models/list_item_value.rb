class ListItemValue < ApplicationRecord
  belongs_to :list_item
  belongs_to :hierarch_list_item
  belongs_to :value
end
