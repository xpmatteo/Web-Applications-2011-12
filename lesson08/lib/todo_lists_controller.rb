require 'todo_application'

class TodoListsController
  attr_accessor :request, :response
  
  def initialize(repository)
    @repository = repository
  end
  
  def execute
    case request.path
    when "/lists/new" 
      do_new
    when "/lists/create"
      create
    when "/lists/add_item"
      add_item
    when "/lists/show"
      show
    when "/lists/check_item"
      check_item
    else
      index
    end
  end
  
  def check_item
    @repository.check_item(request["item_id"].to_i)
    @response.redirect(show_url)
  end

  def do_new
    render "lists/new.html"
  end

  def create
    @repository.add(TodoList.new(@request["name"]))
    @response.redirect "/"    
  end
  
  def add_item
    list_id = @request["list_id"].to_i
    @repository.add_item list_id, @request["description"]
    
    @response.redirect(show_url)
  end
  
  def index
    template = Template.new("lists/index.html")
    @todo_lists = @repository.all
    @response.write_html template.expand(binding)    
  end
  
  def show
    @todo_list = @repository.find(@request["id"].to_i)
    if @todo_list
      template = Template.new("lists/show.html")
      @response.write_html template.expand(binding)
    else
      @response.status = 404
    end
  end
  
  def show_url
    "/lists/show?id=#{@request["list_id"].to_i}"
  end
  
  def render(template_name)
    template = Template.new(template_name)
    @response.write_html template.expand(binding)        
  end
end
