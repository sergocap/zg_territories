class Organization < ApplicationRecord
  def user
    User.find_by id: user_id
  end

  def owner?(some_user)
    user == some_user
  end
end
