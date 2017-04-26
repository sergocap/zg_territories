source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'activemerchant', git: 'https://github.com/sergocap/active_merchant'
gem 'ancestry'
gem 'awesome_print'
gem 'bootstrap-sass'
gem 'bootstrap-slider-rails'
gem 'bootsy'
gem 'cancan'
gem 'chartkick'
gem 'coffee-rails', '~> 4.2'
gem 'enumerize'
gem 'friendly_id'
gem 'glyphicons-rails'
gem 'groupdate'
gem 'haml-rails'
gem 'hashie'
gem 'inherited_resources'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'
gem 'nested_form'
gem 'openteam-commons'
gem 'paperclip'
gem 'pg'
gem 'progress_bar'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.1'
gem 'ranked-model'
gem 'redis-session-store'
gem 'rest-client'
gem 'russian'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'state_machine'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'vuejs-rails'
gem 'zg_auth_client', git: 'https://github.com/sergocap/zg_auth_client'
gem 'zg_header', git: 'https://github.com/sergocap/zg_header'
gem 'zg_redis_user_connector', git: 'https://github.com/sergocap/zg_redis_user_connector'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'capistrano-db-tasks', '0.4', require: false
  gem 'listen', '~> 3.0.5'
  gem 'openteam-capistrano'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
