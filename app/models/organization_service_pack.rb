class OrganizationServicePack < ApplicationRecord
  belongs_to :organization
  belongs_to :service_pack
end
