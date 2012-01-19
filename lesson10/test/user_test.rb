require "test/unit"
require "todo_application"

class UserTest < Test::Unit::TestCase
  def setup
    @user = User.new({"username" => "pippo"})
  end
  
  def test_initializes_from_params
    assert_equal "pippo", @user["username"]
    assert_equal nil, @user["email"]
    assert_equal nil, @user["url"]
  end
  
  def test_minimal_valid_user
    assert @user.valid?
  end  
  
  def test_invalid_email
    user = User.new({"username" => "pippo", "email" => "invalid"})
    assert ! user.valid?
    assert_equal ["Email is invalid"], user.errors
  end
  
end
