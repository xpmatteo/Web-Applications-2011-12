class User < DataCollection
  def initialize(params={})
    # must initialize DataCollection
    super()
    
    add_attribute "username"
    add_attribute "email"
    add_attribute "url"
    set_from(params)
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