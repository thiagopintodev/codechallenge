require "test_helper"

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test

class BlogTest < ActionDispatch::IntegrationTest
  def given_Im_a_guest_When_I_visit_a_post
    # Given I'm a guest
    visit root_path
    assert_i_am_a_guest

    # When I visit a post
    visit post_path posts(:one)
    assert_text "Title: Post Title One"
  end

  test "Removing - I cannot remove a post" do
    given_Im_a_guest_When_I_visit_a_post

    # Then I do not see a Remove Link
    refute_link "Remove this post"
  end

  test "Commenting - I cannot comment" do
    given_Im_a_guest_When_I_visit_a_post

    # Then I do not see a Comment Link
    refute_link "Comment on this post"
  end

end
