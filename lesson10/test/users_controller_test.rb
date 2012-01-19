require "test/unit"

require "todo_application"
require "util/assert_xpath"

class UsersControllerTest < Test::Unit::TestCase  
  include AssertXPath
  
  def setup
    @request = WebRequest.new
    @response = WebResponse.new
    @repository = UserRepository.new
    @controller = UsersController.new(@repository)
    @controller.request = @request
    @controller.response = @response
  end
  
  def test_new_shows_form
    @request.path = "/users/new"
    @controller.execute
    assert_xpath "//form[@action='/users/create']"
  end
  
  def test_create_validates
    @request.path = "/users/create"
    @controller.execute
    assert_xpath "//ul[@class='errors']/li[text()='Username is required']"    
  end
  
  def test_create_redirects_to_slash
    @request.path = "/users/create"
    @request["username"] = "Pippo"
    @controller.execute
    assert_redirected_to "http://todo-list/"
  end  
end
