require 'todo_application'

class TodoListRepository  
  @@item_id = 0

  def initialize
    @todo_lists = []   
  end
  
  def check_item item_id
    for list in @todo_lists
      for item in list.items
        if item.item_id == item_id
          item.check!
        end
      end
    end
  end
  
  def add(list)
    list.list_id = @todo_lists.size
    @todo_lists << list
  end

  def add_item(list, item_description)
    list_id = (Integer === list) ? list : list.list_id
    item = TodoItem.new(item_description)
    item.item_id = @@item_id
    @@item_id += 1
    find(list_id).add item
    item
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
        @@item_id, @todo_lists = Marshal.load(file)
      end
    end
  end

  def save_on(filename)
    File.open(filename, "w") do |file|
      Marshal.dump([@@item_id, @todo_lists], file)
    end
  end
end

