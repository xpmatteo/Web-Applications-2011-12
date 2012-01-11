#!/usr/bin/env ruby

ROOT = File.dirname(__FILE__) + "/.."
$LOAD_PATH.unshift(ROOT + "/lib")
SAVE_FILE = "/tmp/repo.dat"

require "router"
require "web_request"
require "web_response"
require "todo_lists_controller"
require "todo_list_repository"

request = WebRequest.new
response = WebResponse.new
repository = TodoListRepository.new
repository.load_from(SAVE_FILE)
controller = TodoListsController.new(repository)

router = Router.new
router.add("/lists/create", controller)
router.add("/lists/new", controller)
router.add("/lists/show", controller)
router.add("/", controller)

router.execute(request, response)
response.output(STDOUT)

repository.save_on(SAVE_FILE)

# STDOUT.print "<pre>"
# STDOUT.print ENV.inspect.gsub('",', "\",\n")
# STDOUT.print "</pre>"
