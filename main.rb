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
    BG_COLOR = Gosu::Color::WHITE

    def initialize
        super SIZE*RESOLUTION, SIZE*RESOLUTION, false # initializes basic window
        @caption = 'Conway\'s Game of Life'
        @board = GameOfLife::Board.new(SIZE, RESOLUTION, self)
        @board.populate_random!
        #@board.make_blinker!
        @step_count = 0
    end

    # Called at 60Hz, main game logic
    def update
        if @step_count == 20 # 3 times / s
            @board.step!
            @step_count = 0
        else
            @step_count += 1
        end
    end

    # Draws the screen
    def draw
        self.draw_quad(0, 0, BG_COLOR,
                       self.width, 0, BG_COLOR,
                       self.width, self.height, BG_COLOR,
                       0, self.height, BG_COLOR)
        @board.draw
    end
end

window = GameWindow.new
window.show
