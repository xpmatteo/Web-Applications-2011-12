#!/usr/bin/env ruby
# Produce una scacchiera disegnata con HTML e CSS

require 'lib/response'
require 'lib/request'
require 'lib/board'

board = Board.new
response = Response.new

response.respond_with board.html
