require "template"
require "todo_list"

class TodoListsController
  def initialize(repository)
    @repository = repository
  end
  
  def execute(request, response)
    case request.path
    when "/lists/new" 
      template = Template.new("lists/new.html")
      response.write_html template.expand(binding)        
    when "/lists/create"
      @repository.add(TodoList.new(request["name"]))
      response.redirect "/"
    when "/lists/show"
      show(request, response)
    else
      index(request, response)
    end
  end
  
  def index(request, response)
    template = Template.new("lists/index.html")
    @todo_lists = @repository.all
    response.write_html template.expand(binding)    
  end
  
  def show(request, response)
    @todo_list = @repository.find(request["id"].to_i)
    if @todo_list
      template = Template.new("lists/show.html")
      response.write_html template.expand(binding)
    else
      response.status = 404
    end
  end
end
