
class Router
  def initialize
    @paths = []
  end
  
  def add(path, controller)
    @paths << [path, controller]
  end

  def execute(request, response) 
    @paths.each do |path, controller|
      if request.path === path
        controller.execute(request, response)
        return
      end
    end
    response.status = 404
  end
end

