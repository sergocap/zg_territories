class ServicePack < ApplicationRecord
  has_many :organization_service_packs
  has_many :organizations, :through => :organization_service_packs
  extend Enumerize
  enumerize :tag, :in => [:minimal, :base, :full], :default => :minimal

  def left_days(organization_id)
    organization_service_packs.where(:organization_id => organization_id).first.left_days
  end

  def has_services
    arr = []
    [:logotype, :gallery, :price_list, :brand, :description_field, :small_comment].each do |service|
      self.send(service) ? arr << service : []
    end
    arr
  end
end
