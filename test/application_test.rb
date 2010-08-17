class ApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Application
  end

  def setup
    DatabaseCleaner.clean
  end

  def test_default
    get '/'
    assert_equal "http://example.org/", last_request.url
  end
end
