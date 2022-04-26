require "test_helper"

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test

class BlogTest < ActionDispatch::IntegrationTest
  def given_Im_a_user
    # Given I'm a user
    sign_in users(:one)
  end

  test "Creating - I can see the create form modal" do
    given_Im_a_user

    # When I write
    refute_text "New Post"
    click_link "Write"

    # Then I see a form
    assert_text "New Post"
  end

  test "Creating - I cannot create an invalid post" do
    given_Im_a_user

    # When I write an invalid post
    click_link "Write"

    fill_in "Title", with: "12"
    fill_in "Body", with: "12"
    click_button "Create"

    # Then I see validation errors
    assert_text "Title is too short (minimum is 3 characters)"
    assert_text "Body is too short (minimum is 3 characters)"
  end

  test "Creating - I can create a valid post" do
    given_Im_a_user

    # When I write a valid post
    click_link "Write"

    fill_in "Title", with: "Best Post Ever"
    fill_in "Body", with: "123"
    click_button "Create"

    # Then I see validation errors
    assert_text "Post was successfully created."
    assert_text "User: One"
    assert_text "Title: Best Post Ever"
  end

  test "Updating - I cannot update an invalid post" do
    given_Im_a_user

    # When I update a post invalidly
    visit post_path posts(:one)
    assert_text "Post Title One"
    refute_text "Post Title Updated"
    click_link "Edit this post"

    fill_in "Title", with: "12"
    fill_in "Body", with: "12"
    click_button "Update"

    # Then I see validation errors
    assert_text "Title is too short (minimum is 3 characters)"
    assert_text "Body is too short (minimum is 3 characters)"
  end

  test "Updating - I can update a valid post" do
    given_Im_a_user

    # When I update a post validly
    visit post_path posts(:one)
    assert_text "Post Title One"
    refute_text "Post Title Updated"
    click_link "Edit this post"

    fill_in "Title", with: "Best Post Ever"
    fill_in "Body", with: "123"
    click_button "Update"

    # Then I see a success message
    assert_text "Post was successfully updated."
    assert_text "User: One"
    assert_text "Title: Best Post Ever"
  end

  test "Removing - I can remove a post" do
    given_Im_a_user

    # When I remove a post
    visit post_path posts(:one)
    assert_text "Post Title One"
    refute_text "Post Title Updated"
    click_link "Remove this post"
    click_link "Remove"

    # Then I see validation errors
    assert_text "Post was successfully destroyed."
  end

end
