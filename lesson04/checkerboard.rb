#!/usr/bin/env ruby
# Produce una scacchiera disegnata con HTML e CSS

printf "Content-Type: text/html\r\n"
printf "\r\n"

def cell_class(r, c)
  if (r+c) % 2 == 0
    "even"
  else
    "odd"
  end  
end

def params
  p = {}
  if ENV["REQUEST_METHOD"] == "GET"
    query_string = ENV["QUERY_STRING"]
  else
    query_string = gets
  end
  query_string.split("&").each do |pair|
    key = pair.split("=")[0]
    value = pair.split("=")[1]
    p[key] = value
  end
  p
end

def find_my_size
  size = params["size"] || 8
  size.to_i
end


printf '
  <style type="text/css">
    table { border: 1px solid black; }
    td { width: 1em; }
    td.even { background-color: black; }
  </style>
'

size = find_my_size
printf "<table>\n"
r=0
c=0
while r < size
  printf "<tr>\n"
  while c < size
    printf "  <td class='#{cell_class(r,c)}'>&nbsp;</td>\n"
    c = c + 1
  end
  printf "</tr>\n"
  r = r + 1
  c = 0
end
printf '</table>'

printf "
<div style='margin-top: 2em'>
  <form method='post'>
  <input type='text' name='size' value='#{size}' />
  <input type='submit' value='cambia dimensione' />
  </form>
</div>
"
