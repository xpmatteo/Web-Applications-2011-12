class UsersController < Controller
  attr_accessor :request, :response
  
  def execute
    if request.path == "/users/new"
      @user = User.new
      render "users/new.html"
    elsif request.path == "/users/create"
      @user = User.new(request)
      if @user.valid?
        # repository.add(@user)
        render "users/show.html"
      else
        render "users/new.html"
      end
    else
      response.status = 404
    end
  end
end