module ApiWithProfile
  class SendMail
    def self.organization_to_draft(user_id, organization)
      @organization = organization
      organization_link = gen_organization_link(organization)

      RestClient.get URI::encode(Settings['profile']['api'] +
        "/mail_organization_to_draft?" +
        "user_id=#{user_id}&" +
        "organization_title=#{organization.title}&" +
        "organization_link=#{organization_link}")
    end

    def self.organization_to_public(user_id, organization)
    end

    private
    def self.gen_organization_link(organization)
      [Settings['app']['host'],  organization.city.slug, 'organizations', organization.id.to_s].join('/')
    end
  end
end
