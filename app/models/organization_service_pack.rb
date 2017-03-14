class OrganizationServicePack < ApplicationRecord
  belongs_to :organization
  belongs_to :service_pack
  validates_presence_of :organization_id, :service_pack_id, :duration

  def left_days
    (created_at + duration.months - Time.now).to_i/60/60/24
  end
end
