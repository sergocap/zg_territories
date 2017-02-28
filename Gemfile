source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rest-client'
gem 'inherited_resources'
gem 'cancan'
gem 'ranked-model'
gem 'zg_auth_client', git: 'https://github.com/sergocap/zg_auth_client'
gem 'zg_redis_user_connector', git: 'https://github.com/sergocap/zg_redis_user_connector'
gem 'zg_header', git: 'https://github.com/sergocap/zg_header'
gem 'simple_form'
gem 'pg'
gem 'kaminari'
gem 'haml-rails'
gem 'vuejs-rails'
gem 'friendly_id'
gem 'nested_form'
gem 'enumerize'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'russian'
gem 'bootstrap-slider-rails'
gem 'glyphicons-rails'
gem 'ancestry'
gem 'awesome_print'
gem 'redis-session-store'
gem 'rails', '~> 5.0.1'
gem 'config'
gem 'hashie'
gem 'state_machine'
gem 'progress_bar'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
