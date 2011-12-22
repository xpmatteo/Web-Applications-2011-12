#!/bin/bash
# Produce una scacchiera disegnata con HTML e CSS

printf 'Content-Type: text/html\r\n'
printf '\r\n'

# interpretare l'input

# TODO leggere il parametro "size" dalla query string.
# Se il parametro non è stato passato, allora usare il 
# default di 8

# elaborare

# produrre l'output

function cell_class() {
  if [ $(( ($r + $c) % 2 )) = "0" ]; then
    echo "even"
  else
    echo "odd"
  fi  
}

printf '
  <style type="text/css">
    table { border: 1px solid black; }
    td { width: 1em; }
    td.even { background-color: black; }
  </style>
'

printf '<table>\n'
r=0
c=0
while [ $r -lt 8 ]; do
  printf "<tr>"
  while [ $c -lt 8 ]; do
    printf "  <td class='$(cell_class)'>&nbsp;</td>\n"
    c=$(( $c + 1 ))
  done
  printf "</tr>\n"
  r=$(( $r + 1 ))
  c=0
done
printf '</table>'
