require 'simplecov'
SimpleCov.start


require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
abort("The Rails environment is running in production mode!") if Rails.env.production?
# Add additional requires below this line. Rails is not loaded until this point!
#
Dir[Rails.root.join('spec_support', '**', '*.rb')].each { |f| require f }
#
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end
  config.extend ControllerMacros, :type => :controller

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
