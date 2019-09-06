class Board
    # protected
    attr_reader :board, :slots
    def initialize
    @board = [  [' ',' ',' '],
                [' ',' ',' '],
                [' ',' ',' ']
                            ]
    @slots = [[1,2,3],[4,5,6],[7,8,9]]
    @ticks = 0
    # players = {}
    end

    def draw board
        for i in (0..2)
            board[i].each {|x| print "[#{x}]"}
            puts
        end
        # puts @example.inspect
    end

    def tick arr,player
        @board[arr[0]][arr[1]] = 'x' if player == 0
        @board[arr[0]][arr[1]] = 'o' if player == 1
        @ticks += 1
    end
  

    def check_winner? arr
        gewinn = @board[arr[0]][arr[1]]

        #diagonal win
        if arr[0] == arr[1]
            for i in (0..2)
                if @board[i][i] != gewinn
                    break 
                end
                return true if i==2    
            end
            
        end

        #anti-diagonal win
        if arr[0] + arr[1] == 2
            j=2
            for i in (0..2)
                if @board[i][j] != gewinn
                    break
                end
                j-=1
                return true if i==2
            end
        end
        
        #column win
        for i in (0..2)
            if @board[i][arr[1]] != gewinn
                break
            end
            return true if i==2
        end

        #row win
        for i in (0..2)
            if @board[arr[0]][i] !=gewinn
                break
            end
            return true if i==2
        end

        #end-game (draw)
        if @ticks == 9
            puts 'Draw..!!'
            exit
        end
    end

    def box_ticks nummer
        x=[nil,nil]
        case nummer
        when 1
            x[0] = 0
            x[1] = 0
        when 2
            x[0] = 0
            x[1] = 1
        when  3
            x[0] = 0
            x[1] = 2
        when  4
            x[0] = 1
            x[1] = 0
        when  5
            x[0] = 1
            x[1] = 1
        when  6
            x[0] = 1
            x[1] = 2
        when  7
            x[0] = 2
            x[1] = 0
        when  8
            x[0] = 2
            x[1] = 1
        when  9
            x[0] = 2
            x[1] = 2
        end
        x
    end

    def ticked? box
        if @board[box[0]][box[1]] != ' '
            return true
        end
        false
    end

end

class Game
    def initialize
        @board = Board.new()
        @player1 = ''
        @player2 = ''
        @players = []
        @turn = 0
    end

    def greet
        puts 'Player 1 name ?'
        @player1 = gets.chomp
        puts 'Player 2 name ?'
        @player2 = gets.chomp
        @players.push(@player1,@player2)
        puts "Hello, #{@players[0]} & #{@players[1]}\nLet's Start"
        @board.draw @board.slots
        
    end

    def legit_choice
        num = nil
        loop do
            puts "It's your turn #{@players[@turn%2].capitalize}, Insert a number"
            num = gets.chomp.to_i
            while num<1 or num>9
                puts "Sorry, an invalid number"
                puts "Insert a number from 1 to 9"
                num = gets.chomp.to_i
            end
            while @board.ticked?(@board.box_ticks(num))
                puts "This Box is Already Ticked"
                puts "Insert another number from 1 to 9"
                num = gets.chomp.to_i
            end
            break
        end
        num
    end

    def turn_player
        choice = legit_choice
        puts "#{@players[@turn%2].capitalize}'s choice': #{choice} ."
        @board.tick @board.box_ticks(choice), @turn%2
        @board.draw @board.board
        if @board.check_winner? @board.box_ticks(choice)
            puts "Hooray, #{@players[@turn%2].capitalize} wins..!!"
            puts "Hard luck #{@players[(@turn+1)%2].capitalize} .."
            exit
        end
        @turn +=1
    end

    def play

        greet
        loop do
            turn_player
        end
    end

end

    

m = Board.new()
g = Game.new()
g.play




