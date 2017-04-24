class MyResourceRequest < ApplicationRecord
  belongs_to :organization

  def user
    User.find_by id: user_id
  end
end
