require './gameoflife'
require 'gosu'

# puts "Please enter size of board: "
# size = gets.chomp.to_i
# size
# b = GameOfLife::Board.new(size)
# b.populate_random!
# b.print

class GameWindow < Gosu::Window
    def initialize
        super 640, 480, false # initializes basic window
        self.caption = 'Conway\'s Game of Life'
    end

    # Called at 60Hz, main game logic
    def update
    end

    # Draws the screen
    def draw
    end
end

window = GameWindow.new
window.show
