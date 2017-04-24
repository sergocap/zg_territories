module ApiWithProfile
  def self.get_users_id_by(key, value)
    JSON.parse RestClient.get Settings['profile.api_get_users_id_by'], { params: { key: key, value: value } }
  end

  def self.send_mail_about_state(new_state, organization, message = nil)
    action_view = get_action_view

    body = action_view.render partial: 'common/render_mails/about_' + new_state + '_state',
      locals: { :organization => organization, :message => message }, layout: false

    subject = case new_state
              when 'draft'
                '[ZnaiGorod] Ваша организация была отправлена в черновики'
              when 'published'
                '[ZnaiGorod] Ваша организация была опубликована'
              end

    send_mail(organization.user.id, subject, body)
  end

  def self.send_mail_about_role(user, organization, organization_manager)
    action_view = get_action_view

    body = action_view.render partial: 'common/render_mails/about_role',
      locals: { :organization => organization,
                :user => user,
                :organization_manager => organization_manager }, layout: false

    subject = '[ZnaiGorod] Подтверждение роли'

    send_mail(user.id, subject, body)
  end

  def self.send_mail_about_main_role(user, organization)
    action_view = get_action_view

    body = action_view.render partial: 'common/render_mails/about_main_role',
      locals: { :organization => organization,
                :user => user}, layout: false

    subject = '[ZnaiGorod] Вам присвоили организацию'

    send_mail(user.id, subject, body)
  end

  def self.send_mail_about_resource_request_state(user, organization, resource_request)
    action_view = get_action_view

    body = action_view.render partial: 'common/render_mails/about_resource_request_state',
      locals: { :organization => organization, :resource_request => resource_request,
                :user => user}, layout: false

    subject = '[ZnaiGorod] Ответ на заявку о владении ресурса'

    send_mail(user.id, subject, body)

  end


  def self.send_mail(user_id, subject, body)
    RestClient.get Settings['profile.api_send_mail'], { params: { user_id: user_id, subject: subject, body: body } }
  end

  def self.main_city_id_by_ip(ip)
    JSON.parse RestClient.get(Settings['profile.api_main_city_id_by_ip'], { params: { ip: ip } })
  end

  private
  def self.get_action_view
    action_view ||= ActionView::Base.new(Rails.configuration.paths["app/views"])
    action_view.class_eval do
       include Rails.application.routes.url_helpers
        def default_url_options
          { :host => Settings['app.host'] }
        end
    end
    action_view
  end
end
