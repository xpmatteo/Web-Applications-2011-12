#!/usr/bin/env ruby

ROOT = File.dirname(__FILE__) + "/.."
$LOAD_PATH.unshift(ROOT + "/lib")
SAVE_FILE = "/tmp/repo.dat"

require 'todo_application'

request = WebRequest.new
response = WebResponse.new
begin
  repository = TodoListRepository.new
  repository.load_from(SAVE_FILE)
  controller = TodoListsController.new(repository)

  router = Router.new
  router.add(/^\/lists/, controller)
  router.add("/", controller)

  router.execute(request, response)

  repository.save_on(SAVE_FILE)  
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
