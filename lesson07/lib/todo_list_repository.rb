class TodoListRepository
  def initialize
    @todo_lists = []    
  end
  
  def add(list)
    @todo_lists << list
  end
  
  def all
    @todo_lists
  end
  
  def size
    @todo_lists.size
  end
  
  def last
    @todo_lists.last
  end
end

