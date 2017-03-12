class ServicePack < ApplicationRecord
  has_many :organization_service_packs
  has_many :organizations, :through => :organization_service_packs
  extend Enumerize
  enumerize :tag, :in => [:minimal, :base, :full], :default => :minimal
end
