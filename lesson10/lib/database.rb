
require 'rubygems'
require 'mysql'

class Database

  def connection
    @connection ||= Mysql.connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME)
  end

  def select(sql, *args)
    statement = execute(sql, *args)
    result = []
    names = column_names(statement)
    while values = statement.fetch
      result << build_row(names, values)
    end
    statement.free_result
    statement.close
    result
  end

  def select_one_value(sql)
    select(sql).first.values.first
  end

  def execute(sql, *args)
    statement = connection.prepare(sql)
    statement.execute(*args)
    statement
  end

  def insert(sql, *args)
    execute(sql, *args)
    select_one_value("select last_insert_id()")
  end
  
  private
  
  def build_row(names, values)
    result = {}
    for i in (0...names.size)
      result[names[i]] = values[i]
    end
    result
  end

  def column_names(statement)
    metadata = statement.result_metadata
    result = []
    while field = metadata.fetch_field
      result << field.name
    end
    result
  end
end