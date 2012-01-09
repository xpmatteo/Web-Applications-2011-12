#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.dirname(__FILE__) + "/../lib")

root = File.dirname(__FILE__)

require "todo_app"
require "web_request"
require "web_response"
require "home_page"
require "todo_list_repository"

request = WebRequest.new
response = WebResponse.new
app = TodoApp.new
home_page = HomePage.new(TodoListRepository.new)
app.add("/", home_page)
app.add("/lists/new", home_page)
app.add("/lists/create", home_page)
app.execute(request, response)
response.output(STDOUT)

# STDOUT.print "<pre>"
# STDOUT.print ENV.inspect.gsub('",', "\",\n")
# STDOUT.print "</pre>"
