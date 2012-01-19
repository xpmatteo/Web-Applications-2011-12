require "test/unit"

require "database"
require File.dirname(__FILE__) + "/../config/test"

class DatabaseTest < Test::Unit::TestCase
  
  def setup
    assert connection
    assert_equal "todolist_test", db_select_one_value("select database()")
    db_execute "drop table if exists pippo"
    db_execute "create table pippo (
      a integer auto_increment primary key,
      b varchar(255));"    
  end
  
  def test_select
    actual = db_select "select (2 + 2) as quattro"
    assert_equal [{"quattro" => "4"}], actual
  end
  
  def test_select_one
    assert_equal "6", db_select_one_value("select 2 * 3")
  end
  
  def test_parameters_to_sql
    db_insert("insert into pippo (b) values (?)", "zot")
    assert_equal "zot", db_select_one_value("select b from pippo")
  end
  
  def test_execute
    assert_equal "0", db_select_one_value("select count(*) from pippo")
  end
  
  def test_db_insert
    new_id = db_insert "insert into pippo (a) values (null)"
    assert_equal "1", new_id
    
    new_id = db_insert "insert into pippo (a) values (null)"
    assert_equal "2", new_id
  end
  
end

