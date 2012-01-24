require 'todo_application'

class TodoList < DataCollection
  attr_reader :name
  attr_accessor :todo_list_id
  
  def initialize(name)
    @name = name
    @items = []
  end
  
  def items
    @items.reject { |item| item.checked? }
  end
  
  def add item
    case item
    when String
      @items << TodoItem.new(item)
    else
      @items << item
    end
  end
  
  def checked_items
    @items.select { |item| item.checked? }
  end
  
  def validate
    if blank?(name)
      add_error "Name is required"
    end
    if name && name.length < 3
      add_error "Name must be longer than 3 characters"
    end
  end
  
  def ==(other)
    [self.todo_list_id, self.name] == [other.todo_list_id, other.name]
  end
end
