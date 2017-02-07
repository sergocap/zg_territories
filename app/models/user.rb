class User
  include ZgAuthClient::User

  acts_as_auth_client_user

  def app_name
    'org_test'
  end
end
