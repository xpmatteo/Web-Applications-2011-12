
class WebRequest  
  attr_accessor :path

  def initialize
    load_params
    load_path
  end

  def [](index)
    @params[index]    
  end
  
  def []=(index, value)
    @params[index] = value
  end
  
  private
  
  def load_path
    @path = ENV["REQUEST_URI"].to_s.split("?")[0]
  end
  
  def load_params
    @params = {}
    if ENV["REQUEST_METHOD"] == "GET"
      query_string = ENV["QUERY_STRING"]
    elsif ENV["REQUEST_METHOD"] == "POST"
      query_string = gets
    else
      query_string = ""
    end
    query_string.split("&").each do |pair|
      key = pair.split("=")[0]
      value = pair.split("=")[1]
      @params[key] = value
    end
  end  
end
