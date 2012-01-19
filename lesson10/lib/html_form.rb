class HtmlForm
  attr_reader :html
  
  def initialize
    @html = ""
  end
  
  def add_text_field(name, value="")
    @html += "
    <p>
      <label for=\"#{name}\">#{name.capitalize}</label><br/>
      <input type=\"text\" name=\"#{name}\" value='#{value}' id=\"#{name}\"/>        
    </p>
"
  end
end