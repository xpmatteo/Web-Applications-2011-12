require "test/unit"

require "web_request"

class WebRequestTest < Test::Unit::TestCase
  def test_parses_path
    ENV["REQUEST_URI"] = "/a/b/c"
    request = WebRequest.new
    assert_equal "/a/b/c", request.path
  end


  def test_path_does_not_include_query_string
    ENV["REQUEST_URI"] = "/a?foo=bar"
    request = WebRequest.new
    assert_equal "/a", request.path
  end
end
