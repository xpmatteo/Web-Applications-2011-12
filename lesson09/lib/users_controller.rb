class UsersController < Controller
  attr_accessor :request, :response
  
  def initialize(repository)
    @repository = repository
  end
  
  def execute
    if request.path == "/users/new"
      do_new
    elsif request.path == "/users/create"
      create
    else
      response.status = 404
    end
  end
  
  def do_new
    @user = User.new
    render "users/new.html"    
  end
  
  def create
    @user = User.new(request)
    if @user.valid?
      @repository.add(@user)
      @response.redirect "/"
    else
      render "users/new.html"
    end    
  end
end
