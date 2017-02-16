class User
  include ZgAuthClient::User

  acts_as_auth_client_user

  def app_name
    'zg_organizations'
  end

  def ==(other_user)
    self.id == other_user.try(:id)
  end

  def organizations
    Organization.where(:user_id => self.id)
  end
end
