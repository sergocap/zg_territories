require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OrgTest
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.enable_dependency_loading = true
    config.autoload_paths += %W[
      #{config.root}/lib
    ]
  end
end
