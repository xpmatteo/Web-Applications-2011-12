require "test/unit"
require 'rexml/document'
require 'rexml/xpath'

require "todo_lists_controller"
require "web_request.rb"
require "web_response.rb"
require "todo_list"
require "todo_list_repository"

class TodoListsControllerTest < Test::Unit::TestCase
  def setup
    @request = WebRequest.new
    @response = WebResponse.new

    @repository = TodoListRepository.new
    @repository.add TodoList.new("one")
    @repository.add TodoList.new("two")
    @controller = TodoListsController.new(@repository)
  end

  def test_shows_a_list_of_lists
    @controller.execute(@request, @response)
    assert_xpath "//ul/li/a[text()='one'][@href='/lists/show?id=0']"
    assert_xpath "//ul/li/a[text()='two'][@href='/lists/show?id=1']"
  end
  
  def test_shows_link_to_create_new_list
    @controller.execute(@request, @response)
    assert_xpath "//a[@href='/lists/new'][text()='Create New List']"
  end
  
  def test_returns_list_creation_form
    @request.path = "/lists/new"
    @controller.execute(@request, @response)
    assert_xpath "//form[@action='/lists/create']"
    assert_xpath "//form[@action='/lists/create']//input[@type='text'][@name='name'][@value='']"
  end

  def test_creates_new_list
    @request.path = "/lists/create"
    @request["name"] = "Foobar"

    old_size = @repository.size
    @controller.execute(@request, @response)
    assert_equal old_size + 1, @repository.size
    assert_equal "Foobar", @repository.last.name
  end

  def test_redirects_to_home_page
    @request.path = "/lists/create"
    @request["name"] = "Foobar"

    @controller.execute(@request, @response)
    assert_redirected_to "http://todo-list/"
  end

  private

  def assert_redirected_to(path)
    assert_equal 302, @response.status
    assert_equal path, @response.headers("location")
  end

  def assert_xpath path
    document = REXML::Document.new(@response.body)
    nodes = REXML::XPath.match(document, path)
    assert nodes.size == 1, "Exactly one element matching #{path} expected" + "\n" + @response.body
  end
end

