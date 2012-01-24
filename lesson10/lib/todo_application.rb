
require 'database'
require 'data_collection'
require 'controller'
require 'html_form'
require 'router'
require 'template'
require 'todo_item'
require 'todo_list'
require 'user_repository'
require 'todo_list_repository'
require 'todo_lists_controller'
require 'user'
require 'users_controller'
require 'web_request'
require 'web_response'

def we_are_testing
  # il nome del file ruby che eseguiamo finisce con "_test.rb"?
  /_test.rb$/ === $0
end

if we_are_testing
  require File.dirname(__FILE__) + "/../config/test"
else
  require File.dirname(__FILE__) + "/../config/current_configuration"
end
