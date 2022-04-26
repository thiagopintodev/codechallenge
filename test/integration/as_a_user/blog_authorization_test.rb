require "test_helper"

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test

class BlogAuthorizationTest < ActionDispatch::IntegrationTest
  def given_Im_a_user
    # Given I'm a user
    sign_in users(:one)
  end

  test "Authorization - I cannot remove another user's post" do
    given_Im_a_user

    # When I visit a post I didn't create
    post = Post.create! title: "A Post By Another User", body: "aaaaa", user: users(:two)
    visit post_path post

    # Then I should see the Remove Link
    assert_text "Title: A Post By Another User"
    assert_link "Remove this post"

    # When I click the Remove Link
    click_link "Remove this post"

    # Then I see an error alert
    accept_confirm 'You are not authorized to perform this action'
  end

end
