class Organization < ApplicationRecord
  validates_presence_of :title, :address, message: 'Не может быть пустым'

  def user
    User.find_by id: user_id
  end

  def owner?(some_user)
    user == some_user
  end
end