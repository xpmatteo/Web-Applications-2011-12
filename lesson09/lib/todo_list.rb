require 'todo_application'

class TodoList
  attr_reader :name
  attr_accessor :list_id
  
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
end
