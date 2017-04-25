class Organization < ApplicationRecord
  belongs_to :category
  has_many :statistics, :dependent => :destroy
  has_many :values, :dependent => :destroy
  has_many :schedules, :dependent => :destroy
  has_many :children, class_name: 'Organization', foreign_key: 'parent_id'
  has_many :organization_managers,  :dependent => :destroy
  has_many :organization_service_packs,  :dependent => :destroy
  has_many :service_packs, :through => :organization_service_packs
  has_many :gallery_images, :dependent => :destroy
  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :values
  accepts_nested_attributes_for :schedules, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :gallery_images, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :address,   :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of :title
  validates_presence_of :category, :message => 'Укажите категорию'
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Неверный email'
  validate :check_necessarily
  has_attached_file :logotype, styles: { medium: "300x300>", thumb: "100x100>"  }, default_url: "/images/missing.jpg"
  validates_attachment_content_type :logotype, content_type: /\Aimage\/.*\z/

  include SettingsStateMachine
  include Bootsy::Container
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  delegate :latitude, :longitude, :to => :address, :allow_nil => true
  after_initialize :set_initial_status

  def can_service?(service)
    permit_services.include? service
    true #загрушка для территорий
  end

  def permitted_logotype_url
    can_service?(:logotype) ? logotype.url : '/images/missing.jpg'
  end

  def permit_services
    service_packs.map {|pack| pack.has_services }.flatten.uniq
    [:logotype, :gallery, :description_field]
  end

  def add_statistic(kind = 'show')
    statistics.create(:kind => kind)
  end

  def set_initial_status
    self.state ||= :draft
  end

  def self.states_list
    [:draft, :published, :moderation]
  end

  searchable do
    text    :title
    text    :string_values do
      values.map(&:string_value).compact
    end
    string  :state
  end

  def parent
    Organization.where(:id => parent_id).first
  end

  def user
    User.find_by id: user_id
  end

  def city
    MainCities.instance.find_by :id, city_id
  end

  def managers
    organization_managers.map(&:manager)
  end

  def owner?(some_user)
    user == some_user
  end

  def manager?(user)
    managers.include? user
  end

  def is_child?
    !parent_id.nil?
  end

  def check_necessarily
    values.each do |value|
      errors.add(value.property.title, 'Не может быть пустым') if !value.get.present? && category_property(value.property).necessarily
    end
  end

  def pretty_values
    '{' + values.map {|value| '"'+ value.id.to_s + '":' + value.pretty_view }.join(',') + '}'
  end

  private
  def category_property(property)
    CategoryProperty.where(:category_id => category.id, :property_id => property.id).first
  end
end
