require "test_helper"

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "I can sign up" do
    # Given I'm a guest
    visit root_path
    assert_i_am_a_guest

    # When I sign Up
    click_link "Sign up"
    assert_button "Sign up"

    fill_in "Name", with: "Thiago Pinto"
    fill_in "Email", with: "new@rails7.com"
    fill_in "Password", with: "rails7rocks"
    fill_in "Password confirmation", with: "rails7rocks"
    click_button "Sign up"
    assert_text "Welcome! You have signed up successfully."

    # Then I should be a user
    assert_i_am_a_user
  end

  test "I can sign in" do
    # Given I'm a guest
    visit root_path
    assert_i_am_a_guest

    # When I sign In
    click_link "Log in"
    assert_button "Log in"

    fill_in "Email", with: "one@rails7.com"
    fill_in "Password", with: "rails7rocks"
    click_button "Log in"
    assert_text "Signed in successfully."

    # Then I should be a user
    assert_i_am_a_user
  end

  test "I can sign out" do
    # Given I'm a user
    sign_in users(:one)
    assert_i_am_a_user

    # When I sign out
    click_link "Sign out"
    accept_confirm
    assert_text "Signed out successfully."

    # Then I should be a guest
    assert_i_am_a_guest
  end

  test "TODO: More Tests for Devise-like libraries" do
    skip <<-STR
      In a real-world scenario, I believe all features of complex third-party libraries, such as Devise,
      should be tested with Capybara in order to ensure that future upgrades won't accidentally break things.

      I also believe most custom code (written by the team) should be tested more thoroughly, and at a unit level,
      while some custom code (specially the one that relies on framework built-in features) should be left untested.

      Having said those, it is also my general belief the boundaries of what an application should and should not test
      must be determined by a team in a way that enables individuals to make smart decisions on their own.

      An illustration of such a collaborative process could be:
      0. All team members keep up with the latest rules;
      1. Members talk to each other when edge cases are found;
      2. Members may recommend changes to the rules.
    STR
  end
end
