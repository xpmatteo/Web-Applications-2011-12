require "test/unit"

require "todo_list"
require "todo_item"

class TestTodoList < Test::Unit::TestCase
  def setup
    @list = TodoList.new("pippo")
  end
  
  def test_has_a_name
    assert_equal "pippo", @list.name
  end
  
  def test_initially_has_no_items
    assert_equal [], @list.items
  end
  
  def test_can_add_items
    foo = TodoItem.new("foo")
    bar = TodoItem.new("bar")
    @list.add foo
    @list.add bar
    assert_equal [foo, bar], @list.items
  end
  
  def test_can_check_items_done
    item = TodoItem.new("zot")
    assert !item.checked?
    item.check!
    assert item.checked?, "was not checked"
  end
  
  def test_item_has_description
    item = TodoItem.new("ueila")
    assert_equal "ueila", item.description
  end
  
  def test_return_list_of_checked_items
    item = TodoItem.new("ueila")
    @list.add(item)
    assert_equal [item], @list.items
    assert_equal [], @list.checked_items
    item.check!
    assert_equal [], @list.items
    assert_equal [item], @list.checked_items
  end
end