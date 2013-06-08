#!/usr/bin/ruby
#load "gameoflife.rb"
require './gameoflife'

puts "Please enter size of board: "
size = gets.chomp.to_i
size
b = GameOfLife::Board.new(size)
b.populate_random
b.print
