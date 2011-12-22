class Template
  def initialize(file_path)
    File.open(file_path, "r") do |open_file|
      @template_contents = open_file.read
    end
  end
  
  def expand(variables)
    ERB.new(@template_contents).result(variables)
  end
end

