require 'test/unit'
require 'rexml/document'
require 'stringio'

root = File.dirname(__FILE__) + "/.."
require root + "/lib/web_response"
require root + "/lib/web_request"
require root + "/lib/todo_app"

class TodoAppTest < Test::Unit::TestCase

  def setup
    @request = WebRequest.new
    @response = WebResponse.new
  end

  def test_returns_404
    app = TodoApp.new
    @request.path = "/notexistent"
    app.execute(@request, @response)
    assert_equal 404, @response.status
  end

  class HelloWorldPage
    def execute(request, response)
      response.write_html("Hello, World!")
    end
  end

  def test_returns_content_of_a_page
    app = TodoApp.new
    app.add "/hello", HelloWorldPage.new
    @request.path = "/hello"
    app.execute(@request, @response)
    assert_equal "Hello, World!", @response.body
    assert_equal 200, @response.status
  end

  # def test_shows_a_list_of_lists
  #   repository = ListRepository.new
  #   repository.add TodoList.new("one")
  #   repository.add TodoList.new("two")
  #   page = HomePage.new(repository)
  #   page.respond(@response)
  #   assert_xpath "//a[@text='one']"
  #   assert_xpath "//a[@text='two']"
  # end

  def assert_xpath path
    document = REXML::Document.new(@response.body)
  end
end
