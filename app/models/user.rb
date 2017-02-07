class User
  include AuthClient::User

  acts_as_auth_client_user

  def app_name
    'org_test'
  end

  def redis_info
    get_info
  end
end
