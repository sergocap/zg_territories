module ApiWithProfile
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

  def self.send_mail(user_id, subject, body)
    RestClient.get Settings['profile']['api'] + '/send_mail', { params: { user_id: user_id, subject: subject, body: body } }
  end

  private
  def self.get_action_view
    action_view ||= ActionView::Base.new(Rails.configuration.paths["app/views"])
    action_view.class_eval do
       include Rails.application.routes.url_helpers
        def default_url_options
          { :host => Settings['app']['host'] }
        end
    end
    action_view
  end
end
