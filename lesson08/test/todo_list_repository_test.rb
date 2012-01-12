require "test/unit"

require 'todo_application'

class TodoListRepositoryTest < Test::Unit::TestCase
  def setup
    @repository = TodoListRepository.new
    @list = TodoList.new("name")
    @repository.add(@list)
  end
  
  def test_saves_objects_with_id
    assert_equal 0, @list.list_id
  end
  
  def test_finds_objects_by_id
    assert_equal @list, @repository.find(@list.list_id)    
  end
  
  def test_adds_items_to_a_list
    @repository.add_item(@list.list_id, "a description")
    @repository.add_item(@list.list_id, "another description")
    
    items = @repository.find(@list.list_id).items
    
    assert_equal 2, items.size
    first_item = items[0]
    assert_equal 0, first_item.item_id
    assert_equal "a description", first_item.description
    assert ! first_item.checked?
    
    second_item = items[1]
    assert_equal 1, second_item.item_id
  end
  
  def test_checks_item
    item = @repository.add_item(@list, "a description")
    @repository.check_item(item.item_id)
    
    items = @repository.find(@list.list_id).checked_items
    assert items[0].checked?
  end
  
  def test_save_and_load
    temp_file = "/tmp/temporary.dat"
    @repository.save_on(temp_file)
    other = TodoListRepository.new
    other.load_from(temp_file)
  end
  
end