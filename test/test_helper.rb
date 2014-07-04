ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# # Configure FactoryGirl with Test::Unit for now.
# # !!!
# # Move to MiniTest ASAP.
# class Test::Unit::TestCase
#   include FactoryGirl::Syntax::Methods
# end

class ActionController::TestCase
  include Devise::TestHelpers
end
