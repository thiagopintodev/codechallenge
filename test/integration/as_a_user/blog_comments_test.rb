require "test_helper"

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test

class BlogCommentsTest < ActionDispatch::IntegrationTest
  def given_Im_a_user
    # Given I'm a user
    sign_in users(:one)
  end

  test "Commenting - I can comment validly" do
    given_Im_a_user

    # When I comment on a post validly
    visit post_path posts(:one)
    click_link "Comment on this post"

    fill_in "Title", with: "Best Comment Ever"
    fill_in "Body", with: "123"
    click_button "Comment"

    # Then I see the comment on display
    assert_text "Title: Best Comment Ever"
  end

  test "Commenting - I cannot comment invalidly" do
    given_Im_a_user

    # When I comment on a post invalidly
    visit post_path posts(:one)
    click_link "Comment on this post"

    fill_in "Title", with: "1"
    fill_in "Body", with: "1"
    click_button "Comment"

    # Then I see validation errors
    assert_text "Title is too short (minimum is 3 characters)"
    assert_text "Body is too short (minimum is 3 characters)"
  end

  test "Comment Pagination - I cannot see a button for pagination with 2 comments" do
    given_Im_a_user

    # Given a post has two comments
    assert_equal 2, posts(:one).comments.count

    # When I visit the post page
    visit post_path posts(:one)

    # Then I do not see a link to fetch older comments
    refute_link "Fetch Older Comments"
  end

  test "Comment Pagination - I can see a button for pagination with 3 comments" do
    given_Im_a_user

    # Given a post has three comments
    Comment.create! title: "aaaaa", body: "aaaaa", user: users(:one), post: posts(:one)
    assert_equal 3, posts(:one).comments.count

    # When I visit the post page
    visit post_path posts(:one)

    # Then I do see a link to fetch older comments
    assert_link "Fetch Older Comments"
  end

  test "Comment Pagination - I can paginate" do
    given_Im_a_user

    # Given a post has 3 comments
    Comment.create! title: "aaaaa", body: "aaaaa", user: users(:one), post: posts(:one)
    Comment.create! title: "bbbbb", body: "bbbbb", user: users(:one), post: posts(:one)
    Comment.create! title: "ccccc", body: "ccccc", user: users(:one), post: posts(:one)
    assert_equal 5, posts(:one).comments.count

    # And I visit the post page, and see 3 comments, but do not see 2 comments
    visit post_path posts(:one)
    refute_text "Comment Title 1"
    refute_text "Comment Title 2"
    assert_text "aaaaa"
    assert_text "bbbbb"
    assert_text "ccccc"

    # When I fetch older comments
    click_link "Fetch Older Comments"

    # Then I see all five comments
    assert_text "Comment Title 1"
    assert_text "Comment Title 2"
    assert_text "aaaaa"
    assert_text "bbbbb"
    assert_text "ccccc"
  end

end
