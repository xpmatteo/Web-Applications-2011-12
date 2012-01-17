
require 'rexml/document'
require 'rexml/xpath'

module AssertXPath

  def assert_redirected_to(path)
    assert_equal 302, @response.status
    assert_equal path, @response.headers("location")
  end

  def assert_xpath path, html=@response.body
    document = REXML::Document.new(html)
    nodes = REXML::XPath.match(document, path)
    assert nodes.size == 1, "Exactly one element matching #{path} expected" + "\n" + @response.body
  end
  
end
