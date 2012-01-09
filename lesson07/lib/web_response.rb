
class WebResponse
  attr_reader :body, :status

  def initialize
    @status = 200
    @headers = []
  end

  def write_html(html)
    @body = html
  end

  def status=(status) 
    @headers << "Status: 404 Not Found"
    @body = "<h1>404: Not Found</h1>"
    @status = status
  end

  def output(io)
    for header in @headers
      io.print header + "\r\n"
    end
    io.print "Content-Type: text/html\r\n"
    io.print "\r\n"
    io.print @body
  end
end

