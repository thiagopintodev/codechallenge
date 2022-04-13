ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# https://github.com/teamcapybara/capybara#using-capybara-with-minitest

require 'capybara/rails'
require 'capybara/minitest'

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  # Reset sessions and driver between tests
  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

# NOTE:
# THERE HAVE BEEN A BIG CHANGE IN SYSTEM AND INTEGRATION TESTS BETWEEN RAILS 5 AND 7.
# DEVISE'S DOCUMENTATION OFFERS NO CLEAR SOLUTION ON THIS ISSUE.
# THEREFORE I AM IMPROVISING WITH SOMETHING EASY TO CHANGE LATER.

# https://github.com/heartcombo/devise#integration-tests

class ActionDispatch::IntegrationTest

  # include Devise::Test::IntegrationHelpers

  def sign_in(user)
    # Given I'm a guest
    visit root_path
    assert_text "Guest#root"

    # When I log in
    click_link "Log in"
    assert_button "Log in"

    fill_in "Email", with: user.email
    fill_in "Password", with: 'rails7rocks'
    click_button "Log in"

    # Then I should be a user
    assert_text "Signed in successfully."
    assert_text "User#root"
  end
end
