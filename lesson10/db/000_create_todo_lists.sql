
create table todo_lists (
  todo_list_id int auto_increment,
  name varchar(255) not null,
  primary key(todo_list_id)
);

create table todo_items (
  todo_item_id int auto_increment,
  description varchar(255) not null,
  checked int not null default 0,
  todo_list_id int not null references todo_lists,
  primary key(todo_item_id)      
);
