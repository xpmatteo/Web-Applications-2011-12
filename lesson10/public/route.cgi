#!/usr/bin/env ruby

ROOT = File.dirname(__FILE__) + "/.."
$LOAD_PATH.unshift(ROOT + "/lib")
SAVE_FILE = "/tmp/repo.dat"

require 'todo_application'

request = WebRequest.new
response = WebResponse.new
begin
  todo_list_repository = TodoListRepository.new(Database.new)
  user_repository = UserRepository.new
  lists_controller = TodoListsController.new(todo_list_repository)
  users_controller = UsersController.new(user_repository)
  
  router = Router.new
  router.add(/^\/lists/, lists_controller)
  router.add(/^\/users/, users_controller)
  router.add("/", lists_controller)

  router.execute(request, response)
rescue Exception => e
  response.status = 500
  response.write_html <<-EOF
  <p>#{e}</p>  
  <pre>
  #{e.backtrace.join("\n").gsub(ROOT + '/', '')}
  </pre>
  <pre>  
  Params: #{request}
  </pre>
  EOF
end
response.output(STDOUT)


# STDOUT.print "<pre>"
# STDOUT.print ENV.inspect.gsub('",', "\",\n")
# STDOUT.print "</pre>"
