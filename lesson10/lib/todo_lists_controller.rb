require 'todo_application'

class TodoListsController < Controller
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
    @todo_list = TodoList.new("")
    render "lists/new.html"
  end

  def create
    @todo_list = TodoList.new(@request["name"])
    if @todo_list.valid?
      @repository.add(@todo_list)
      @response.redirect "/"
    else
      render "lists/new.html"
    end
  end
  
  def add_item
    list_id = @request["list_id"].to_i
    @repository.add_item list_id, @request["description"]
    
    @response.redirect(show_url)
  end
  
  def index
    @todo_lists = @repository.all
    render "lists/index.html"
  end
  
  def show
    @todo_list = @repository.find(@request["id"].to_i)
    if @todo_list
      render "lists/show.html"
    else
      @response.status = 404
    end
  end
  
  def show_url
    "/lists/show?id=#{@request["list_id"].to_i}"
  end
end
