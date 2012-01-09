require "test/unit"

require "web_request"

class WebRequestTest < Test::Unit::TestCase
  def test_parses_path
    ENV["REQUEST_URI"] = "/a/b/c"
    request = WebRequest.new
    assert_equal "/a/b/c", request.path
  end
end