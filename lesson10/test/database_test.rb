require "test/unit"

require "todo_application"

class DatabaseTest < Test::Unit::TestCase
  
  def setup
    @database = Database.new
    assert @database.connection
    assert_equal "todolist_test", @database.select_one_value("select database()")
    @database.execute "drop table if exists pippo"
    @database.execute "create table pippo (
      a integer auto_increment primary key,
      b varchar(255));"    
  end

  def test_select
    actual = @database.select "select (2 + 2) as quattro"
    assert_equal [{"quattro" => 4}], actual
  end
  
  def test_select_with_parameter
    @database.insert("insert into pippo (b) values ('zot')")
    actual = @database.select "select b from pippo where b = ?", "zot"
    assert_equal [{"b" => "zot"}], actual
  end
  
  def test_select_many_rows
    @database.insert("insert into pippo (b) values ('one')")
    @database.insert("insert into pippo (b) values ('two')")
    actual = @database.select "select b from pippo order by b"
    assert_equal [{"b" => "one"}, {"b" => "two"}], actual
  end
  
  def test_select_one
    assert_equal 6, @database.select_one_value("select 2 * 3")
  end
  
  def test_insert_with_parameter
    @database.insert("insert into pippo (b) values (?)", "zot")
    assert_equal "zot", @database.select_one_value("select b from pippo")
  end
  
  def test_execute
    assert_equal 0, @database.select_one_value("select count(*) from pippo")
  end
  
  def test_insert_returns_auto_increment_value
    new_id = @database.insert "insert into pippo (a) values (null)"
    assert_equal 1, new_id
    
    new_id = @database.insert "insert into pippo (a) values (null)"
    assert_equal 2, new_id
  end
  
end

