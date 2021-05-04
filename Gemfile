source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'
gem 'rails',                      '~> 6.1.1', '>= 6.0.3.4'
gem 'aws-sdk-s3',                 '~> 1.86.0', require: false
gem 'image_processing',           '~> 1.12.1'
gem 'mini_magick',                '~> 4.11.0'
gem 'active_storage_validations', '~> 0.9.0'
gem 'bcrypt',                     '~> 3.1.7'
gem 'faker',                      '~> 2.15.1'
gem 'will_paginate-bootstrap4',   '~> 0.2.2'
gem 'puma',                       '~> 4.1'
gem 'sass-rails',                 '>= 6'
gem 'webpacker',                  '~> 5'
gem 'turbolinks',                 '~> 5'
gem 'jbuilder',                   '~> 2.7'
gem 'geocoder',                   '~> 1.6', '>= 1.6.4'
gem 'httparty',                   '~> 0.18.1'
gem 'stripe',                     '~> 5.29'
gem 'stripe_event',               '~> 2.3', '>= 2.3.1'
gem 'ransack',                    '~> 2.4', '>= 2.4.1'
gem "recaptcha",                  "~> 5.7"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap',                   '>= 1.5.1', require: false

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3',                  '~> 1.4'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console',              '>= 3.3.0'
  gem 'listen',                   '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',                   '~> 2.1.1'
  gem 'spring-watcher-listen',    '~> 2.0.0'
  gem 'standardrb',               '~> 1.0'
  gem 'rubocop',                  '~> 1.13', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara',                 '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'rails-controller-testing', '1.0.4'
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
