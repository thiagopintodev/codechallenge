require "test_helper"

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "I can sign up" do
    # Given I"m a guest
    visit "/"
    assert_text "Guest#root"
    assert_link "Log in"
    assert_link "Sign up"
    assert_link "Forgot your password?"
    refute_link "Sign out"

    # When I sign Up
    click_link "Sign up"
    assert_button "Sign up"

    fill_in "Name", with: "Thiago Pinto"
    fill_in "Email", with: "new@rails7.com"
    fill_in "Password", with: "rails7rocks"
    fill_in "Password confirmation", with: "rails7rocks"
    click_button "Sign up"
    assert_text "Welcome! You have signed up successfully."

    # Then I should be on the user root page
    assert_text "User#root"
    refute_link "Log in"
    refute_link "Sign up"
    refute_link "Forgot your password?"
    assert_link "Sign out"

    # And my home page should be the user root page
    visit "/"
    assert_text "User#root"
  end

  test "I can sign in" do
    # Given I"m a guest
    visit root_path
    assert_text "Guest#root"
    assert_link "Log in"
    assert_link "Sign up"
    assert_link "Forgot your password?"
    refute_link "Sign out"

    # When I sign In
    click_link "Log in"
    assert_button "Log in"

    fill_in "Email", with: "one@rails7.com"
    fill_in "Password", with: "rails7rocks"
    click_button "Log in"
    assert_text "Signed in successfully."

    # Then I should be on the user root page
    assert_text "User#root"
    refute_link "Log in"
    refute_link "Sign up"
    refute_link "Forgot your password?"
    assert_link "Sign out"

    # And my home page should be the user root page
    visit root_path
    assert_text "User#root"
  end

  test "I can sign out" do
    # Given I'm a user
    sign_in users(:one)

    assert_text "User#root"
    refute_link "Log in"
    refute_link "Sign up"
    refute_link "Forgot your password?"
    assert_link "Sign out"

    # When I sign out
    click_link "Sign out"
    assert_text "Signed out successfully."

    # Then I should be on the guest root page
    assert_text "Guest#root"

    # And my home page should be the guest root page
    visit root_path
    assert_text "Guest#root"
  end
end
