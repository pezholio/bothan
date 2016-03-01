ENV['RACK_ENV'] = 'test'

require 'metrics-api'
require 'data_kitten'
require 'rack/test'
require 'webmock/rspec'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

require 'dotenv'
Dotenv.load

class TestHelper
  include Helpers
end

module RSpecMixin
  include Rack::Test::Methods
  def app
    MetricsApi
  end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
  Kernel.srand config.seed
end
