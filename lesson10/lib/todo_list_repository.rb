require 'todo_application'

class TodoListRepository  
  
  def add(list)
    db_insert "insert into todo_lists (name) values (?)", list.name    
  end

  def add_item(list, item_description)
    sql = "insert into todo_items (description, todo_list_id) values (?,?)"
    db_insert sql, item_description, list.todo_list_id
  end
  
  def check_item item_id
    sql = "update todo_items set checked = 1 where todo_item_id = ?"
    db_execute sql, item_id
  end
  
  def find(list_id)
    rows = db_select("select * from todo_lists where list_id = ?", list_id)
    if rows.size == 0
      raise "List not found #{list_id}"
    end
    todo_list_from_row(rows[0])
  end
  
  def all
    rows = db_select("select * from todo_lists order by todo_list_id")
    result = []
    for row in rows
      result << todo_list_from_row(row)
    end
    result
  end
  
  def size
    db_select_one_value "select count(*) from todo_lists"
  end
  
  def last
    sql = "select * from todo_lists order by todo_list_id desc limit 1"
    rows = db_select(sql)
    if rows.size == 0
      raise "List not found (last)"
    end
    todo_list_from_row(rows[0])    
  end
  
  private
  
  def todo_list_from_row(row)
    todo_list = TodoList.new(row["name"])
    todo_list.todo_list_id = row["todo_list_id"]
    todo_list    
  end
end

