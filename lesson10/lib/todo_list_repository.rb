require 'todo_application'

class TodoListRepository  

  def initialize(database)
    @database = database
  end
  
  def add(list)
    the_id = @database.insert("insert into todo_lists (name) values (?)", list.name)
    list.todo_list_id = the_id
  end

  def add_item(list, item_description)
    if Integer === list
      id = list
    else
      id = list.todo_list_id
    end
    sql = "insert into todo_items (description, todo_list_id) values (?,?)"
    @database.insert sql, item_description, id
  end
  
  def check_item item_id
    sql = "update todo_items set checked = 1 where todo_item_id = ?"
    @database.execute sql, item_id
  end
  
  def find(list_id)
    find_by_sql("select * from todo_lists where todo_list_id = ?", list_id)
  end
  
  def last
    find_by_sql "select * from todo_lists order by todo_list_id desc limit 1"
  end
  
  def all
    list_rows = @database.select("select * from todo_lists order by todo_list_id")
    result = []
    for list_row in list_rows
      # N+1 queries!!! Performance problem here !!!
      result << make_todo_list(list_row, find_items(list_row["todo_list_id"]))
    end
    result
  end
  
  def size
    @database.select_one_value "select count(*) from todo_lists"
  end
  
  private
  
  def make_todo_list(row, items)
    todo_list = TodoList.new(row["name"])
    todo_list.todo_list_id = row["todo_list_id"]
    items.each do |item|
      todo_list.add item
    end
    todo_list    
  end
  
  def find_items(todo_list_id)
    items = []
    rows = @database.select("select * from todo_items where todo_list_id = ?", todo_list_id)
    rows.each do |row|
      items << TodoItem.new(row)
    end
    items
  end
  
  def find_by_sql(sql, *args)
    rows = @database.select(sql, *args)
    if rows.size == 0
      raise "List not found #{list_id}"
    end
    items = find_items(rows[0]["todo_list_id"])
    make_todo_list(rows[0], items)    
  end
end

