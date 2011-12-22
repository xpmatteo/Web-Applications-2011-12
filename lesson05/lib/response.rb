
class Response
  def respond_with(html)
    printf "Content-Type: text/html\r\n"
    printf "\r\n"
    printf "%s", html
  end
end

