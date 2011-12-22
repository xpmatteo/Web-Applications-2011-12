#!/bin/bash

printf 'Content-Type: text/html\r\n'
printf '\r\n'

printf '<h1>Ora del giorno</h1>'
printf '<p>'
date +'%d-%m-%Y %H:%M:%S'
printf '</p>'

