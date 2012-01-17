class DataCollection
  attr_accessor :attribute_names
  
  def initialize(params={})
    @attributes = {}
    for name in attribute_names
      @attributes[name] = params[name]
    end    
  end
  
  def [](name)
    @attributes[name]
  end
  
  def attributes
    @attributes
  end
  
  def valid?
    @errors = []
    validate
    errors.nil? || errors.empty?
  end
  
  def errors
    @errors 
  end
  
  def add_error(message)
    if @errors.nil?
      @errors = []
    end
    @errors << message
  end  

  def add_fields_to_form(form)
    for name in @attribute_names
      form.add_text_field name, attributes[name]
    end
  end  
  
  def blank?(string)
    string.nil? || string.empty? || string.strip.empty?
  end
end
