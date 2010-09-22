require File.join(File.expand_path('../../', __FILE__), 'test_helper.rb')

class UserTest < Test::Unit::TestCase
  def setup
    DatabaseCleaner.clean
  end

  def test_create_users
    user = Factory.create(:user)
    assert_not_nil user
    assert_equal user.name, "Myname"
  end

  def test_update_users
    user = Factory.create(:user)

    user = User.find_by_name "Myname"
    user.name = "Foo"
    user.save!

    assert_equal user.name, "Foo"
    user.name = "Myname"
    user.save!
    assert_equal user.name, "Myname"
  end

  def test_destroy_users
    Factory.create(:user)
    user = User.first
    publisher = Publisher.new(Factory.attributes_for(:publisher))
    publisher.user = user
    assert publisher.save
    feed_entry = FeedEntry.new(Factory.attributes_for(:feed_entry))
    feed_entry.user = user
    assert feed_entry.save
    issue = Issue.new(Factory.attributes_for(:issue))
    issue.user = user
    assert issue.save
    story = Story.new(Factory.attributes_for(:story))
    story.user = user
    story.feed_entry = feed_entry
    assert story.save
    figure = Figure.new(Factory.attributes_for(:figure))
    figure.user = user
    assert figure.save
    tweet = Tweet.new(Factory.attributes_for(:tweet))
    Factory.create(:twitter_user)
    tw_user = TwitterUser.first
    tweet.user = user
    tweet.twitter_user = tw_user
    assert tweet.save
    tw_search = TwitterSearch.new(Factory.attributes_for(:twitter_search))
    tw_search.user = user
    assert tw_search.save
    assert_not_equal 0, User.count
    assert_not_equal 0, Publisher.count
    assert_not_equal 0, FeedEntry.count
    assert_not_equal 0, Issue.count
    assert_not_equal 0, Story.count
    assert_not_equal 0, Figure.count
    assert_not_equal 0, Tweet.count
    assert_not_equal 0, TwitterSearch.count
    user.destroy
    assert_equal 0, User.count
    assert_equal 0, Publisher.count
    assert_equal 0, FeedEntry.count
    assert_equal 0, Issue.count
    assert_equal 0, Story.count
    assert_equal 0, Figure.count
    assert_equal 0, Tweet.count
    assert_equal 0, TwitterSearch.count
  end
end
