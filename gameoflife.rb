#!/usr/bin/ruby

class Board
    def initialize(s)
        @size = s

        # Makes an array of arrays, each corresponding to a row, filled with dead cells
        @board = Array.new(size, Array.new(size, Cell.new))

    end

    def populate_random(n = @size/2)
        #n.times {}

    end

    def print
        s = ''
        @board.each do |r|
            # Top off each row
            s += "-" * (@size * 2 + 1)
            s += "\n"
            r.each do |c|
                s += "|"
                if c.is_alive?
                    s += "x|"

                else
                    s+= " |"

                end
            end
        end
        # Cap it and print
        s += "-" * (@size * 2 + 1)
        puts s

    end

    # Returns a flattened list of all neighbors of a given location
    # Location must be a 2-member list of coordinates [row, coloumn]
    def get_neighborhood(*location)
        t = @board[location[0]-1].slice(location[1]-1, 3)
        m = @board[location[0]].slice(location[1]-1, 3)
        m.delete_at(1)
        b = @board[location[0]+1].slice(location[1]-1, 3)

        return [t,m,b].flatten

    end
end

class Cell
    def initialize
        @current_state = false
        @next_state = false

    end

    # Populates the next_state var with the proper state
    def calculate_next_state(neighborhood)
        #Check states
        num_live_neighbors = neightborhood.count(true)
        if this.is_alive?
            if num_live_neighbors < 2
                # Starves
                @next_state = false

            elsif num_live_neighbors >= 2 && num_live_neighbors <= 3
                # Survives
                @next_state = true

            else
                # Suffocates
                @next_state = false
                
        else
            if num_live_neighbors == 3
                # Reproduces
                @next_state = true

            else
                # Stays ded
                @next_state = false

    end

    # Boolean wrappers
    def is_alive?
        return @current_state

    end

    def will_be_alive?
        return @next_state

    end
end
