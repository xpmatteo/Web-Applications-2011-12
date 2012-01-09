
class WebRequest  
  attr_accessor :path

  def [](index)
    params[index]    
  end
  
  def params
    p = {}
    if ENV["REQUEST_METHOD"] == "GET"
      query_string = ENV["QUERY_STRING"]
    else
      query_string = gets
    end
    query_string.split("&").each do |pair|
      key = pair.split("=")[0]
      value = pair.split("=")[1]
      p[key] = value
    end
    p
  end  
end
