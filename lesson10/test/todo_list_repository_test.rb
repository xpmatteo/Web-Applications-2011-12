require "test/unit"

require 'todo_application'

class TodoListRepositoryTest < Test::Unit::TestCase
  def setup
    database = Database.new
    @repository = TodoListRepository.new(database)
    @list = TodoList.new("name")
    @repository.add(@list)
  end
  
  def test_saves_objects_with_id
    assert Integer === @list.todo_list_id
  end
  
  def test_finds_objects_by_id
    assert_equal @list, @repository.find(@list.todo_list_id)    
  end
  
  def test_adds_items_to_a_list
    @repository.add_item(@list, "a description")
    @repository.add_item(@list, "another description")
    
    items = @repository.find(@list.todo_list_id).items
    
    assert_equal 2, items.size
    first_item = items[0]
    assert Integer === first_item.todo_item_id
    assert_equal "a description", first_item.description
    assert ! first_item.checked?
    
    second_item = items[1]
    assert_equal "another description", second_item.description
  end
  
  def test_checks_item
    todo_item_id = @repository.add_item(@list, "a description")
    @repository.check_item(todo_item_id)
    
    items = @repository.find(@list.todo_list_id).checked_items
    assert items[0].checked?
  end
end