require 'test/unit'
require 'stringio'

require "web_response"

class WebResponseTest < Test::Unit::TestCase

  def setup
    @response = WebResponse.new
  end

  def test_response_writes_headers_and_body
    buffer = StringIO.new
    @response.write_html("Hello, World!")
    @response.output(buffer)

    expected = 
      "Content-Type: text/html\r\n" +
      "\r\n" +
      "Hello, World!"
    assert_equal expected, buffer.string
    assert_equal 200, @response.status
  end

  def test_response_returns_404
    buffer = StringIO.new
    @response.status = 404
    @response.output(buffer)
    
    expected = 
      "Status: 404 Not Found\r\n" +
      "Content-Type: text/html\r\n" +      
      "\r\n" +
      "<h1>404 Not Found</h1>"
    assert_equal expected, buffer.string
    assert_equal 404, @response.status
  end

  def test_redirects
    buffer = StringIO.new
    @response.redirect "/foo/bar"
    @response.output(buffer)
    
    expected = 
      "Status: 302 Found\r\n" +
      "Location: http://todo-list/foo/bar\r\n" +      
      "Content-Type: text/html\r\n" +      
      "\r\n" +
      "<h1>302 Found</h1>"
    assert_equal expected, buffer.string
    assert_equal 302, @response.status
  end
end
