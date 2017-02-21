class Organization < ApplicationRecord
  has_many :values
  belongs_to :category
  accepts_nested_attributes_for :values
  validates_presence_of :title, :address, message: 'Не может быть пустым'
  has_many :children, class_name: 'Organization', foreign_key: 'parent_id'

  paginates_per 20

  searchable include: [:values] do
    integer :list_item_ids, multiple: true do
      values.map { |value| value.list_items.map(&:id) + [] << value.list_item_id }.flatten.compact
    end

    integer :hierarch_list_item_ids, multiple: true do
      values.map(&:hierarch_list_item).compact.map(&:id)
    end

    integer :category_id
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
