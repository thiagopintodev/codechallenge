require "test_helper"

# https://guides.rubyonrails.org/testing.html#implementing-a-system-test

class BlogPaginationTest < ActionDispatch::IntegrationTest
  def given_Im_a_user
    # Given I'm a user
    sign_in users(:one)
  end

  test "Pagination - Links are shown" do
    given_Im_a_user

    # When I visit the posts page
    visit root_path

    # Then I do see pagination links
    assert_link "Previous"
    assert_link "Next"
  end

end
