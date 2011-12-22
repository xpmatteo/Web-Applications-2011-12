require 'erb'

class Board
  def html
    @description = h("Scacchiera che <script>alert('siete degli allocchi!!')</script>")
    @size = find_my_size
    t = Template.new "templates/board.erb"
    t.expand(binding)
  end
  
  def h(html)
    html.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;")
  end
  
  def find_my_size
    request = Request.new 
    size = request["size"] || 8
    size.to_i
  end
  
  def cell_class(r, c)
    if (r+c) % 2 == 0
      "even"
    else
      "odd"
    end  
  end  
end

