#!/usr/bin/ruby
module GameOfLife
    class Board
        BORDER = 10
        def initialize(s)
            @size = s

            # Makes an array of arrays, each corresponding to a row, filled with dead cells
            @board = Array.new(@size+BORDER) { Array.new(@size+BORDER) { Cell.new } }

        end

        # Run one turn of the game
        def step!
            # This can be sped up significantly by skipping, which I will do later
            # Run next-state calculation
            @size.times do |r|
                @size.times do |c|
                    self.get_cell(r,c).set_next_state!(self.get_neighborhood(r,c))

                end
            end

            # This can also probably be sped up by not going through twice
            # Evolve!
            @size.times do |r|
                @size.times do |c|
                    self.get_cell(r,c).step!

                end
            end
        end

        def get_cell(r, c)
            return @board[r][c]

        end

        def populate_random!(n = @size/2)
            puts n.to_s if $DEBUG
            n.times { self.get_cell(Random.rand(@size), Random.rand(@size)).birth! }

        end

        def print
            s = ''
            @size.times do |r|
                # Top off each row
                s << "-" * (@size * 2 + 1)
                s << "\n|"
                @size.times do |c|
                    if self.get_cell(r,c).is_alive?
                        s << 'x|'

                    else
                        s << ' |'

                    end
                end
                s << "\n"

            end

            # Cap it and print
            s << "-" * (@size * 2 + 1)
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
        def set_next_state!(neighborhood)
            #Check states
            num_live_neighbors = neighborhood.count { |x| x.is_alive? }
            if self.is_alive?
                if num_live_neighbors < 2
                    # Starves
                    puts "Cell #{self} starves" if $DEBUG
                    @next_state = false

                elsif num_live_neighbors >= 2 && num_live_neighbors <= 3
                    # Survives
                    puts "Cell #{self} lives" if $DEBUG
                    @next_state = true

                else
                    # Suffocates
                    puts "Cell #{self} suffocates" if $DEBUG
                    @next_state = false

                end 
            else
                if num_live_neighbors == 3
                    # Reproduces
                    @next_state = true

                else
                    # Stays ded
                    @next_state = false

                end
            end
        end

        def step!
            @current_state = @next_state

        end

        # Boolean wrappers
        def is_alive?
            return @current_state

        end

        # Undefined unless next state has been calculated
        def will_be_alive?
            return @next_state

        end

        # State affectors
        def birth!
            @current_state = true

        end

        def kill!
            @current_state = false

        end
    end
end
