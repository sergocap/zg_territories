class Organization < ApplicationRecord
  has_many :values
  belongs_to :category
  belongs_to :city
  accepts_nested_attributes_for :values
  validates_presence_of :title, :address, message: 'Не может быть пустым'
  has_many :children, class_name: 'Organization', foreign_key: 'parent_id'
  include SettingsStateMachine

  after_initialize :set_initial_status

  def set_initial_status
    self.state ||= :draft
  end

  def self.states_list
    [:draft, :published, :moderation]
  end

  searchable include: [:values] do
    integer :list_item_ids, multiple: true do
      values.map {|value| value.list_items.map(&:id) + [] << value.list_item_id }.
        flatten.compact
    end

    integer :hierarch_list_item_ids, multiple: true do
      values.map(&:hierarch_list_item).compact.map(&:id)
    end

    text    :string_values do
      values.map(&:string_value).compact
    end

    integer :category_id
    integer :city_id
    string  :state
    text    :title
  end

  def parent
    Organization.where(:id => parent_id).first
  end

  def user
    User.find_by id: user_id
  end

  def owner?(some_user)
    user == some_user
  end

  def is_child?
    !parent_id.nil?
  end
end
