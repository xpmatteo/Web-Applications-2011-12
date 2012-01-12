
class Router
  def initialize
    @paths = []
  end
  
  def add(path, controller)
    @paths << [path, controller]
  end

  def execute(request, response) 
    @paths.each do |path, controller|
      if path === request.path
        controller.request = request
        controller.response = response
        controller.execute
        return
      end
    end
    response.status = 404
  end
end

