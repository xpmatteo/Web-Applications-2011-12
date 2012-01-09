
class TodoApp
  def add(path, page)
    @path, @page = [path, page]
  end

  def execute(request, response) 
    if request.path == @path
      @page.execute(request, response)
    else
      response.status = 404
    end
  end
end

