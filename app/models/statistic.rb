class Statistic < ApplicationRecord
  belongs_to :organization
  scope :for_show, ->  { where(:kind => 'show') }
  scope :for_phone, -> { where(:kind => 'phone') }
end
