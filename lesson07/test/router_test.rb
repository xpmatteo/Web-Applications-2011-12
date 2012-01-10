require 'test/unit'
require 'stringio'

require "web_response"
require "web_request"
require "router"

class RouterTest < Test::Unit::TestCase

  def setup
    @request = WebRequest.new
    @response = WebResponse.new
    @router = Router.new
  end

  def test_returns_404
    @request.path = "/notexistent"
    @router.execute(@request, @response)
    assert_equal 404, @response.status
  end

  class HelloWorldPage
    def execute(request, response)
      response.write_html("Hello, World!")
    end
  end

  def test_returns_content_of_a_page
    @router.add "/hello", HelloWorldPage.new
    @request.path = "/hello"
    @router.execute(@request, @response)
    assert_equal "Hello, World!", @response.body
    assert_equal 200, @response.status
  end
end
