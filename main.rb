require './gameoflife'
require 'gosu'

# puts "Please enter size of board: "
# size = gets.chomp.to_i
# size
# b = GameOfLife::Board.new(size)
# b.populate_random!
# b.print

class GameWindow < Gosu::Window
    attr_accessor :board
    SIZE = 15 # number of rows / cols
    RESOLUTION = 12 # number of pixels per grid space

    def initialize
        super SIZE*RESOLUTION, SIZE*RESOLUTION, false # initializes basic window
        @caption = 'Conway\'s Game of Life'
        @board = GameOfLife::Board.new(SIZE, RESOLUTION, self)
        @board.populate_random!
        @update_interval = 500
    end

    # Called at 60Hz, main game logic
    def update
        @board.step!
    end

    # Draws the screen
    def draw
        @board.draw
    end
end

window = GameWindow.new
window.show
