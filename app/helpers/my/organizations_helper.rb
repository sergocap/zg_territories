module My::OrganizationsHelper
  def check_init_schedule
    (!@organization.persisted? && @organization.errors.size.zero?) ? 'init_schedule' : ''
  end
end
