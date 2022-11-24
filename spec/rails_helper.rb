# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'

require File.expand_path('../dummy/config/environment', __FILE__)

require 'rspec/rails'
require 'capybara/rails'
require "selenium-webdriver"
require 'database_cleaner'

Capybara.javascript_driver = :selenium_headless

def reload_menus!
  if Float(ENV['RAILS_VERSION']) >= 4.0
    ActiveAdmin.application.namespaces.each { |n| n.reset_menu! }
  else
    ActiveAdmin.application.namespaces.values.each { |n| n.reset_menu! }
  end
end

def reload_routes!
  Rails.application.reload_routes!
end

# Setup ActiveAdmin
ActiveAdmin.application.load_paths = [File.expand_path("../dummy/app/admin", __FILE__)]
ActiveAdmin.unload!
ActiveAdmin.load!
reload_menus!
reload_routes!

# Disabling authentication in specs so that we don't have to worry about
# it allover the place
ActiveAdmin.application.authentication_method = false
ActiveAdmin.application.current_user_method = false

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_spec_type_from_file_location!

  config.include Devise::TestHelpers, type: :controller
  config.include WaitForAjax, type: :feature
end
