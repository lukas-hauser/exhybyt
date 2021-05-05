# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Load the custom environment variables here, so they are loaded before environments/*.rb
unless Rails.env.production?
  app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
  load(app_environment_variables) if File.exist?(app_environment_variables)
end

# Initialize the Rails application.
Rails.application.initialize!
