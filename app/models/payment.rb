class Payment < ApplicationRecord
  belongs_to :paymentable, :polymorphic => true
  belongs_to :organization
  extend Enumerize
  enumerize :state, in: [:pending, :approved, :canceled], default: :pending
  validates_presence_of :amount, :user_id, :organization_id

  def user
    User.find_by id: user_id
  end

  def approved?
    state == 'approved'
  end

  def service_url
    if Rails.env.development?
      "http://auth.robokassa.ru/Merchant/Index.aspx?" +
        "IsTest=1&" +
        "OutSum=#{amount}&" +
        "MerchantLogin=#{robokassa_login}&" +
        "InvoiceID=#{invoiceID}&" +
        "Signature=#{signature}"
    elsif Rails.env.production?
      #"#{integration_module.service_url}?#{integration_helper.form_fields.to_query}"
    end
  end

  def approve!
    case paymentable
    when ServicePack
      attach_service_pack
    end
    self.state = :approved
    self.save
  end

  private

  def signature
    Digest::MD5.hexdigest(robokassa_login + ':' + amount.to_s + ':' + invoiceID.to_s + ':' + pass1)
  end

  def robokassa_login
    Settings['robokassa']['login']
  end

  def pass1
    Settings['robokassa']['secret_1']
  end

  def invoiceID
    0
  end

  def attach_service_pack
    OrganizationSerivePack.create(:price => amount,
                                  :duration => duration,
                                  :organization_id => organization_id,
                                  :service_pack => paymentable_id)
  end
end