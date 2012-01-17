class User < DataCollection
  def initialize(params={})    
    attribute_names = ["username", "email", "url"]
    super(params)
  end
  
  def validate
    if blank?(attributes["username"])
      add_error "Username is required"
    end
    if attributes["email"] && !(/\w+@\w+\.\w+/ === attributes["email"])
      add_error "Email is invalid"
    end
    if attributes["url"] && ! (/^http/ === attributes["url"])
      add_error "Url is invalid"
    end
  end  
end