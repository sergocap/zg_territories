class Schedule < ApplicationRecord
  has_many   :breaks, dependent: :destroy
  belongs_to :organization
  accepts_nested_attributes_for :breaks, :reject_if => :all_blank, :allow_destroy => true
end
