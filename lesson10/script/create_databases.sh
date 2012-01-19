#!/bin/bash

# define key information
src=db
dbname=todolist_development
dbname_test=todolist_test
dbuser=todolist
dbpassword="segreta"

# no customization needed beyond this line

set -e

cd "$(dirname $0)/.."

read -s -p "mysql root password? (type return for no password) " MYSQL_ROOT_PASSWORD

if [ "$MYSQL_ROOT_PASSWORD" != "" ]; then
    MYSQL_ROOT_PASSWORD=-p$MYSQL_ROOT_PASSWORD
fi

mysqladmin -uroot $MYSQL_ROOT_PASSWORD --force drop $dbname       || true
mysqladmin -uroot $MYSQL_ROOT_PASSWORD --force drop $dbname_test  || true

echo "create database $dbname      default charset utf8;" | mysql -uroot $MYSQL_ROOT_PASSWORD
echo "create database $dbname_test default charset utf8;" | mysql -uroot $MYSQL_ROOT_PASSWORD

echo "grant all on $dbname.* to '$dbuser'@localhost identified by '$dbpassword';" \
     | mysql -uroot $MYSQL_ROOT_PASSWORD 
echo "grant all on $dbname_test.* to '$dbuser'@localhost identified by '$dbpassword';" \
      | mysql -uroot $MYSQL_ROOT_PASSWORD 


cat $src/???_*.sql | mysql -u$dbuser "-p$dbpassword" $dbname 
cat $src/???_*.sql | mysql -u$dbuser "-p$dbpassword" $dbname_test 

echo "$dbname created"
echo "$dbname_test created"
