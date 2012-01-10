class TodoList
  attr_reader :name
  attr_accessor :list_id
  
  def initialize(name)
    @name = name
  end
  
  def items
    ["pippo", "Pluto"]
  end
end

