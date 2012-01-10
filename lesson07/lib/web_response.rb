
class WebResponse
  attr_reader :body, :status

  STATUS_DESCRIPTIONS = {
    200 => "OK",
    302 => "Found",
    404 => "Not Found",
  }

  def initialize
    @status = 200
    @headers = []
  end

  def write_html(html)
    @body = html
  end

  def status=(status) 
    label = "#{status} #{STATUS_DESCRIPTIONS[status]}"
    @headers << "Status: " + label
    @body = "<h1>#{label}</h1>"
    @status = status
  end
  
  def redirect(path)
    self.status = 302
    @headers << "Location: http://todo-list" + path
  end
  
  def headers(name)
    header = @headers.select { |header| starts_with(header, name)  }
    return nil unless header.size > 0
    value(header[0])
  end
  
  def output(io)
    for header in @headers
      io.print header + "\r\n"
    end
    io.print "Content-Type: text/html\r\n"
    io.print "\r\n"
    io.print @body
  end
  
  private
  
  def starts_with(header, name)
    header.downcase.start_with? name.downcase
  end
  
  def value(header)
    header.split(":", 2)[1].strip
  end
end

