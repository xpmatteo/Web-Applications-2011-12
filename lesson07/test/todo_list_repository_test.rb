require "test/unit"

require "todo_list"
require "todo_list_repository"

class TodoListRepositoryTest < Test::Unit::TestCase
  def test_saves_objects_with_id
    repository = TodoListRepository.new
    list = TodoList.new("name")
    repository.add(list)
    assert_equal 0, list.list_id
  end
  
  def test_finds_objects_by_id
    repository = TodoListRepository.new
    list = TodoList.new("name")
    repository.add(list)
    assert_equal list, repository.find(list.list_id)    
  end
end