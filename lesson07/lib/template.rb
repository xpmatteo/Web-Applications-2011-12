require 'erb'

class Template
  TEMPLATES_DIR = File.dirname(__FILE__) + "/../templates/"
  SUFFIX = ".erb"
  
  def initialize(name)
    File.open(TEMPLATES_DIR + name + SUFFIX, "r") do |open_file|
      @template_contents = open_file.read
    end
  end
  
  def expand(variables)
    ERB.new(@template_contents).result(variables)
  end
end

