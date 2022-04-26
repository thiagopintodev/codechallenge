require "test_helper"

class ApplicationRecordTest < ActiveSupport::TestCase
  test "Class Method paginated" do
    Post.create! title: "aaaaa", body: "aaaaa", user: users(:one)
    Post.create! title: "bbbbb", body: "bbbbb", user: users(:one)
    Post.create! title: "ccccc", body: "ccccc", user: users(:one)
    Post.create! title: "ddddd", body: "ddddd", user: users(:one)
    Post.create! title: "eeeee", body: "eeeee", user: users(:one)

    # no args, empty string, 0 or 1 return the same 1st page altogether

    page, pages, posts = Post.paginated()

    assert_equal 1, page
    assert_equal 1..3, pages
    assert_equal ["eeeee", "ddddd", "ccccc"], posts.map(&:title)

    page, pages, posts = Post.paginated("")

    assert_equal 1, page
    assert_equal 1..3, pages
    assert_equal ["eeeee", "ddddd", "ccccc"], posts.map(&:title)

    page, pages, posts = Post.paginated(0)

    assert_equal 1, page
    assert_equal 1..3, pages
    assert_equal ["eeeee", "ddddd", "ccccc"], posts.map(&:title)

    page, pages, posts = Post.paginated(1)

    assert_equal 1, page
    assert_equal 1..3, pages
    assert_equal ["eeeee", "ddddd", "ccccc"], posts.map(&:title)

    # page 2 returns the next records, which match our expectation

    page, pages, posts = Post.paginated(2)

    assert_equal 2, page
    assert_equal 1..3, pages
    assert_equal ["bbbbb", "aaaaa", "Post Title Two"], posts.map(&:title)

    # page 3 returns the next records, which match our expectation

    page, pages, posts = Post.paginated(3)

    assert_equal 3, page
    assert_equal 1..3, pages
    assert_equal ["Post Title One"], posts.map(&:title)
  end

  test "Class Method before" do
    Post.create! title: "aaaaa", body: "aaaaa", user: users(:one)
    Post.create! title: "bbbbb", body: "bbbbb", user: users(:one)
    Post.create! title: "ccccc", body: "ccccc", user: users(:one)
    Post.create! title: "ddddd", body: "ddddd", user: users(:one)
    Post.create! title: "eeeee", body: "eeeee", user: users(:one)

    # no args, empty string or 0 return the same 1st page altogether

    before, posts = Post.before()

    assert_equal "ccccc", before&.title
    assert_equal ["eeeee", "ddddd", "ccccc"], posts.map(&:title)

    before, posts = Post.before("")

    assert_equal "ccccc", before&.title
    assert_equal ["eeeee", "ddddd", "ccccc"], posts.map(&:title)

    before, posts = Post.before(0)

    assert_equal "ccccc", before&.title
    assert_equal ["eeeee", "ddddd", "ccccc"], posts.map(&:title)

    # before "ccccc" returns the next records, which match our expectation

    before, posts = Post.before(before.id)

    assert_equal "Post Title Two", before&.title
    assert_equal ["bbbbb", "aaaaa", "Post Title Two"], posts.map(&:title)

    # before "Post Title Two" returns the next records, which match our expectation

    before, posts = Post.before(before.id)

    assert_equal nil, before&.title
    assert_equal ["Post Title One"], posts.map(&:title)
  end
end
