require "test/unit"

require 'todo_application'
require 'util/assert_xpath'

class TodoListsControllerTest < Test::Unit::TestCase
  include AssertXPath

  def setup
    @request = WebRequest.new
    @response = WebResponse.new

    @repository = TodoListRepository.new    
    @list_one = TodoList.new("one")
    @list_two = TodoList.new("two")
    @repository.add @list_one
    @repository.add @list_two
    @controller = TodoListsController.new(@repository)
    @controller.request = @request
    @controller.response = @response
  end

  def test_shows_a_list_of_lists
    @controller.execute
    assert_xpath "//ul/li/a[text()='one'][@href='#{todo_list_show_url(0)}']"
    assert_xpath "//ul/li/a[text()='two'][@href='#{todo_list_show_url(1)}']"
  end
  
  def test_shows_link_to_create_new_list
    @controller.execute
    assert_xpath "//a[@href='/lists/new'][text()='Create a new List']"
  end

  def test_returns_list_creation_form
    @request.path = "/lists/new"
    @controller.execute
    assert_xpath "//form[@action='/lists/create']"
    assert_xpath "//form[@action='/lists/create']//input[@type='text'][@name='name'][@value='']"
  end

  def test_creates_new_list
    @request.path = "/lists/create"
    @request["name"] = "Foobar"

    old_size = @repository.size
    @controller.execute
    assert_equal old_size + 1, @repository.size
    assert_equal "Foobar", @repository.last.name
  end

  def test_redirects_to_home_page
    @request.path = "/lists/create"
    @request["name"] = "Foobar"

    @controller.execute
    assert_redirected_to "http://todo-list/"
  end

  def test_checks_one_item
    item = @repository.add_item @list_one, "an item"
    @request.path = "/lists/check_item"
    @request["list_id"] = @list_one.list_id.to_s
    @request["item_id"] = item.item_id.to_s

    @controller.execute
    assert_redirected_to "http://todo-list" + todo_list_show_url(@list_one)
    assert item.checked?, "not checked?"
  end

  private

  def todo_list_show_url(list)
    list_id = 
      if Integer === list
        list
      else
        list.list_id
      end
    "/lists/show?id=#{list_id}" 
  end
end
