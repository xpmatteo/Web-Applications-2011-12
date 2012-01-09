require "template"

class HomePage
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
    else
      template = Template.new("home_page.html")
      @todo_lists = @repository.all
      response.write_html template.expand(binding)        
    end
  end
end
