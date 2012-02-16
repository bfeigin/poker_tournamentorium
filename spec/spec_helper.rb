PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.expand_path(File.dirname(__FILE__) + "/factories")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.mock_with :mocha
end

# Clean out the database before each test run.
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  EnovaPoker.tap { |app|  }
end
