require "test/unit"

require 'todo_application'

class TodoListRepositoryTest < Test::Unit::TestCase
  def setup
    database = Database.new
    database.execute "delete from todo_items"
    database.execute "delete from todo_lists"
    @repository = TodoListRepository.new(database)
    @list = TodoList.new("name")
    @repository.add(@list)    
  end
  
  def test_saves_objects_with_id
    assert Integer === @list.todo_list_id
  end
  
  def test_finds_list_by_id
    @repository.add_item @list, "an item"
    found = @repository.find(@list.todo_list_id)
    assert_equal @list, found
    assert_equal 1, found.items.size
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
  
  def test_adds_items_passing_list_id
    id = @list.todo_list_id
    @repository.add_item(id, "a description")
    items = @repository.find(id).items
    
    assert_equal 1, items.size
    first_item = items[0]
    assert_equal "a description", first_item.description
  end
  
  def test_checks_item
    todo_item_id = @repository.add_item(@list, "a description")
    @repository.check_item(todo_item_id)
    
    items = @repository.find(@list.todo_list_id).checked_items
    assert items[0].checked?
  end
  
  def test_finds_all_lists
    other_list = TodoList.new("another")
    @repository.add(other_list)
    @repository.add_item other_list, "first item"
    @repository.add_item other_list, "second item"
    all = @repository.all

    assert_equal 2, all.size
    second_found_list = all[1]
    assert_equal "another", second_found_list.name
    assert_equal 2, second_found_list.items.size
    assert_equal "first item", second_found_list.items[0].description
    assert_equal "second item", second_found_list.items[1].description
  end
end