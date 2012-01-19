class Controller

  def render(template_name)
    template = Template.new(template_name)
    @response.write_html template.expand(binding)        
  end
  
end