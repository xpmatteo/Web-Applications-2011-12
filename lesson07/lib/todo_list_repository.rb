class TodoListRepository
  def initialize
    @todo_lists = []    
  end
  
  def add(list)
    list.list_id = @todo_lists.size
    @todo_lists << list
  end
  
  def find(list_id)
    @todo_lists[list_id]
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
  
  def load_from(filename)
    if File.exist?(filename)
      File.open(filename, "r") do |file|
        @todo_lists = Marshal.load(file)
      end
    end
  end

  def save_on(filename)
    File.open(filename, "w") do |file|
      Marshal.dump(@todo_lists, file)
    end
  end
end

