require 'todo_application'

class TodoItem
  attr_accessor :description, :item_id
  
  def initialize(description)
    @description = description
    @checked = false
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