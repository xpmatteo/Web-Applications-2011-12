require 'todo_application'

class TodoItem
  attr_accessor :description, :todo_item_id
  
  def initialize(data)
    case data
    when String
      @description = data
      @checked = false
    when Hash
      @description = data["description"]
      @checked = data["checked"] != 0
      @todo_item_id = data["todo_item_id"]
    end
  end
  
  def check!
    @checked = true
  end
  
  def checked?
    @checked
  end
  
  def to_s
    @description
  end
end