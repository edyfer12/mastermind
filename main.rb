#Include require.colorize that would enable the font-colour and background-colour for the 
#string value

#Create a class called Game where rules are set, set number of games are played, colour patterns
#are created for the codemaker and guesser, play multiple games and decoding_board is both 
#printed and updated.
class Game 
    #Declare a class variable called number of games
    @@number_of_games
    #Declare a constant array called players
    PLAYERS = ['guesser', 'codemaker']
    #Declare constant variable called MAX_GUESSES and assign to 12 where guesser can take 12 turns
    MAX_GUESSES = 12
    #Declare constant variable called NUM_LARGE_HOLES and assign to 4 where guesser picks 4 colours
    NUM_LARGE_HOLES = 4
    #Declare constant variable called NUM_SMALL_HOLES and assign to 4 where guesser recieves feedback from the 
    #codemaker
    NUM_SMALL_HOLES = 4
    #Add constructor method where human and computer objects are created
    def initialize
        #Create game_count variable and set to 0
        @game_count = 0
        #Create a human object passing in game_count and players array
        @human = Human.new(@game_count, PLAYERS)
        #Create a computer object passing in human
        @computer = Computer.new(@human)
        #Assign class variable number_of_games to class method set_number_of_games 
        @@number_of_games = self.set_num_of_games
        #Create code_pegs array and store 'red', 'orange', 'pink', 'green', 'brown', 'yellow'.
        #Players can nominate the colour that exists in the code_pegs
        @code_pegs = ['red', 'orange', 'pink', 'green', 'brown', 'yellow']
        self.create_rules
        self.nominate_colours_codemaker
    end
    #Create an instance method called set_num_of_games
    def set_num_of_games
        #Keep looping to allow the user to type in the input until the value is an integer,
        #is at least 2 and is even number
        loop do  
            #Notify the user to enter the number of games
            print "Please enter the number of games: "
            #Declare variable called num_of_games and set to input
            num_of_games = gets.chomp
            #If num_of_games is not a number or includes non-numeric string other than . and -, 
            if num_of_games.match(/[^0-9.-]/) || 
            (num_of_games.match(/[0-9]/) && num_of_games.count(".") > 1) ||
            num_of_games == '' ||
            num_of_games[num_of_games.length - 1] == "." ||
            num_of_games[num_of_games.length - 1] == '-' || 
            num_of_games.match(/[0-9]-[0-9]/)  ||
            num_of_games.count("-") > 1
                #Display error "Not a number: Try Again"
                puts "Not a number: Try Again"
            #If num_of_games is not an integer, but is a number, 
            elsif num_of_games.match(/[0-9]/) && num_of_games.include?(".") && num_of_games.count(".") == 1
                #Display error "Not a whole number: Try Again"
                puts "Not a whole number: Try Again"
            #If num_of_games is an integer, but is less than 2 or is not even number,
            elsif num_of_games.match(/[0-9]/) && !num_of_games.include?(".")  &&
                 num_of_games.to_i < 2 || num_of_games.to_i.odd? == true
                #Convert to integer
                num_of_games = num_of_games.to_i
                #Display error "Number has to be an even number at least 2: Try again"
                puts "Number has to be an even number at least 2: Try Again"
            #If num_of_games is an integer and is even number at least 2,
            else
                #Convert to integer
                num_of_games = num_of_games.to_i
                #Return number of games
                return num_of_games
            end
        break if num_of_games.is_a?(Integer) == true && num_of_games >= 2 && num_of_games.even? == true
        end
    end
    #Create an instance method that enables the user to enable the rules of the game whether to allow blank and/or  
    #duplicate colours for both the codemaker and guesser when nominating colour patterns
    def create_rules
        #Output to the user whether to allow blank colours to be used in the game
        puts "Do you want blank colours in the game?"
        #Enable the user to keep entering the input until the blank value is 'yes' or 'no'
        while @blank != "yes" && @blank != "no"
            @blank = gets.chomp.downcase
            #If the user does not enter 'Yes' or 'No', display error message.
            if @blank != 'yes' && @blank != 'no'
            #The error message is 'Input invalid: Try again' and keep looping
                puts "Input Invalid: Try again"    
            end
        end
        #Output to the user whether to allow duplicate colours to be used in the game
        puts "Do you want to allow duplicate colours in the game?"
        #Enable the user to keep entering the input until the duplicate value is 'yes' or 'no'
        while @duplicate != 'yes' && @duplicate != 'no'
            @duplicate = gets.chomp.downcase
            #If the user does not enter 'yes' or 'no', display error message
            if @duplicate != 'yes' && @duplicate != 'no'
            #The error message is 'Input Invalid: Try again' and keep looping 
                puts "Input invalid: Try again"
            end
        end
    end
    #Create an instance method that enables the codemaker to choose four colour patterns based on
    #on the rules of the game
    def nominate_colours_codemaker
        #If the blank instance variable is set to 'Yes', push blank character into code_pegs array
        if @blank == 'yes'
            @code_pegs.push('')
        end
        #Create an array called codemaker
        @codemaker = []
        #If human is a codemaker,
        if @human.player == 'codemaker'
            #Output to the user "Please enter the four colours (red, orange, green, pink, brown, yellow):"
            puts "As a codemaker, please enter the four colours (coloured code pegs are red, orange, green, pink, brown, yellow):"
        end
        #Create variable i and set to 0
        i = 0
        #Keep entering the colours four times as a codemaker
        while(i < 4)
            #If the computer is a codemaker, invoke the method computer_make_code
            if @computer.player == 'codemaker'
                computer_make_code(@code_pegs, @duplicate)
            #Otherwise, invoke the method human_make_code
            else
                human_make_code(@code_pegs, @duplicate)
            end
            #Increment i by 1 to allow more colour to be entered
            i += 1
        end
    end
    #Create instance method that enables the computer codemaker to nominate four colour patterns
    #passing in index of codemaker, code_pegs array and duplicate variable
    def computer_make_code(code_pegs, duplicate)
        #Create variable called randomValue and set to random value in code_pegs
        randomValue = code_pegs.sample
        #Use until loop to select random elements from code_pegs until duplicate value is set to 'Yes' 
        #or duplicate value is set to 'No' and element in codemaker does not exist
        until duplicate == 'yes' || duplicate == 'no' && !@codemaker.include?(randomValue)
            #If duplicate value is set to 'No' and element in codemaker already exists then keep looping
            if duplicate == 'no' && @codemaker.include?(randomValue)
                randomValue = code_pegs.sample
            end
        end
        #Push the randomValue to the codemaker array
        @codemaker.push(randomValue)
    end
    #Create instance method that enables the human codemaker to nominate four colour patterns
    #passing in index of codemaker, code_pegs array and duplicate variable
    def human_make_code(code_pegs, duplicate)
        #Create variable colour and set to input 
        colour = gets.chomp
        #Keep looping until the value of colour variable exists in code_pegs and duplicate is 
        #set to 'Yes' or duplicate is set to 'No' and colour does not exist in codemaker array
        until code_pegs.include?(colour) && (duplicate == 'yes' || (duplicate == 'no' && 
            !@codemaker.include?(colour)))
            #Check if the colour exists in the code_pegs array
            #If not, output error message "Colour does not exist as a code peg: Try again"
            if !code_pegs.include?(colour)
                puts "Colour does not exist as a code peg: Try again"
            end
            #If the duplicate is set to 'No' and colour already exist in codemaker array,
            #Display error message as "Colour already exists in the codemaker row: Try again"
            if duplicate == 'no' && @codemaker.include?(colour)
                puts "Colour already exists in the codemaker row: Try again"
            end
            #Create variable colour and set to input 
            colour = gets.chomp
        end
        #Push the colour to the codemaker array
        @codemaker.push(colour)
    end
    #Create instance method that allows the player to take up to 12 turns. For each turn, the
    #player has to choose a colour to see if it exists in the codemaker's row and shares same 
    #position. After each selection of colour, feedback from the codemaker is provided to the 
    #guesser. White key peg is given to the guesser if the colour guessed exist in the 
    #codemaker but position is different to each other and number of duplicate colour in guesser
    #is less than or equal to the ones in codemaker. Black key peg is given to the guesser if the
    #position and colour match between the guesser and codemaker. No key peg is rewarded if the 
    #colour does not exist in the codemaker or if colour does exist, but not position, where the 
    #number of duplicate colours in guesser is greater than in codemaker.
    def nominate_colours_guesser
        #Create guesser_board variable that is a 2D array that store 12 rows and 4 columns
        @guesser_board = Array.new(12, Array.new(4))
        #Create points variable and set to 0 so the codemaker earns points for each row guessed
        points = 0
        #Create row variable and set to 0 to indicate the start of the turn for the guesser
        row = 0
        #Loop through row to the MAX_GUESSES where the guesser makes 12 turns to get the pattern correctly
        while row < MAX_GUESSES
            #Create col variable and set to 0 to indicate the start of choosing the colour
            col = 0
            #Create feedback array where the guesser gets rewarded a key peg whenever the colour is selected
            feedback = []
            #Output the instruction to the human guesser, "As a guesser please enter four colours (red, orange,
            #green, pink, brown, yellow):"
            puts "As a guesser please enter four colours (coloured code pegs are red, orange, green, pink, brown, yellow):" if @human.player == 'guesser'
            #Loop through col to NUM_LARGE_HOLES so that the guesser is able to nominate four colours for each row
            while col < NUM_LARGE_HOLES
                #If the computer is a guesser, then invoke the method called computer_guess_colour passing in feedback array, duplicate 
                #row and col to actively enable the computer to take turn choosing four colours and be rewarded key peg
                if @computer.player == 'guesser'
                    computer_guess_colour(feedback, @duplicate, row, col)
                else
                #Otherwise, invoke the human_guess_colour passing feedback array, duplicate, row and col so that the human player can take turn choosing
                #four colours and be rewarded key peg
                    human_guess_colour(feedback, @duplicate, row, col)
                end
                #Add col by 1 as way of enabling the guesser to choose the next colour
                col += 1
            end
            #Add points by 1 after col is set to 4 indicating that the guesser has taken the turn to guess four colours in a row.
            #The codemaker earns a point per row that the guesser chooses 4 colours
            points += 1
            #If row is MAX_GUESSES - 1 and feedback row does not include all black colours, which is the last row for the guesser 
            #to take a turn, add points by 1 to show that the codemaker has earned 1 extra point
            if row == MAX_GUESSES - 1 && !feedback.all?('black')
                points += 1
            end
            #If the feedback row contains all four black colours, terminate the outer loop so that there is no more guessing
            if feedback.all?('black')
                break
            end
            #Add row by 1 so the guesser can take another turn selecting the new pattern of four colours
            row += 1
        end 
        #If the computer is a guesser, declare human_points variable and set to points
        if @computer.player == 'guesser'
            @human_points = points
        #Otherwise, declare computer_points variable and set to points
        else
            @computer.player == 'codemaker'
        end
    end
    #Create instance method called computer_guess_colour where feedback array, row, col and duplicate is passed so computer can  
    #choose colours based on the rules
    def computer_guess_colour(feedback, duplicate, row, col)
        #Create a variable called random_value and set to random element from code_pegs 
        random_value = @code_pegs.sample
        #Keep looping until duplicate is 'yes' or duplicate is set to 'no' and random_value does not exist in guesser_board[row][col]
        until duplicate == 'yes' || (duplicate == 'no' && !@guesser_board[row].include?(random_value))
            #If duplicate is set to 'no' and random_value exists in guesser_board, 
            if duplicate == 'no' && @guesser_board[row].include?(random_value)
                #Reassign random_value to a new random element from code_pegs array so the rule is met when guessing the colour in the game
                random_value = @code_pegs.sample
            end
        end
        #Push the colour into the guesser_board[row] so that the nested array can keep track of the value stored
        @guesser_board[row][col] = random_value
        #If the guesser_board[row][col] matches the colour and position in codemaker array, push 'black' into feedback array
        if @codemaker.include?(@guesser_board[row][col]) && @codemaker[col] == @guesser_board[row][col]
            feedback.push('black')
        #If the guesser_board[row][col] matches the colour, not position in codemaker array, and number of selected duplicate colours
        #in the guesser_board[row] is less than or equal to the codemaker's number of select duplicate colours, then push 'white' into
        #feedback array
        elsif @codemaker.include?(@guesser_board[row][col]) && @codemaker[col] != @guesser_board[row][col] &&
            @guesser_board[row].count(@guesser_board[row][col]) <= @codemaker.count(@guesser_board[row][col])
            feedback.push('white')
        #If the guesser_board[row][col] does not have colour that exists in codemaker, or if colour does exist in codemaker, not match in 
        #position, but number of select duplicate colours in guesser_board[row] is greater than in codemaker, then push '' into feedback array
        elsif !@codemaker.include?(@guesser_board[row][col]) || 
            (@codemaker.include?(@guesser_board[row][col]) && @codemaker[col] != @guesser_board[row][col] &&
            @guesser_board[row].count(@guesser_board[row][col]) > @codemaker.count(@guesser_board[row][col]))
            feedback.push('blank')
        end 
    end
    #Create instance method called human_guess_colour where feedback array, row, col and duplicate is passed so human can choose colours based 
    #on the rules    
    def human_guess_colour(feedback, duplicate, row, col)
        #Create a variable called colour and set to input
        colour = gets.chomp
        #Keep looping until colour exists in code_pegs and (duplicate is 'yes' or duplicate is 'no' and colour does not exist in guesser_board[row]
        until @code_pegs.include?(colour) && duplicate == 'no' && !@guesser_board[row].include?(colour)
            #If colour does not exist, display error message to the user "Colour does not exist as a code peg: Try again"
            if !@code_pegs.include?(colour)
                puts "Colour does not exist as a code peg: Try again"
            end
            #If duplicate is 'no' and colour already exists in guesser_board[row], display error message "Cannot have duplicate colour in the guesser row: Try again"
            if duplicate == 'no' && @guesser_board[row].include?(colour)
                puts "Cannot have duplicate colour in the guesser row: Try again"
            end
            #Reassign color to input
            colour = gets.chomp
        end
        #Push colour into the guesser_board[row] to keep track of the value stored in the nested array
        @guesser_board[row][col] = colour
        #If the guesser_board[row][col] matches the colour and position in codemaker array, push 'black' into feedback array
        if @codemaker.include?(@guesser_board[row][col]) && @guesser_board[row][col] == @codemaker[col]
            feedback.push('black')
        #If the guesser_board[row][col] matches the colour, not position in codemaker array, and number of selected duplicate colours
        #in the guesser_board[row] is less than or equal to the codemaker's number of select duplicate colours, then push 'white' into
        #feedback array
        elsif @codemaker.include?(@guesser_board[row][col]) && @guesser_board[row][col] != @codemaker[col] &&
            @guesser_board[row].count(@guesser_board[row][col]) <= @codemaker.count(@guesser_board[row][col])
            feedback.push('white')
        #If the guesser_board[row][col] does not have colour that exists in codemaker, or if colour does exist in codemaker, not match in 
        #position, but number of select duplicate colours in guesser_board[row] is greater than in codemaker, then push '' into feedback array 
        elsif !@codemaker.include?(@guesser_board[row][col]) || 
            (@codemaker.include?(@guesser_board[row][col]) && @guesser_board[row][col] != @codemaker[col] &&
            @guesser_board[row].count(@guesser_board[row][col]) > @codemaker.count(@guesser_board[row][col]))
            feedback.push('blank')
        end
    end
end
#Create a class called Human
class Human
    #Inside the Human class,
        def initialize(game_count, players)
            #Declare an instance variable called player
            @player
            #If game_count is 0, then assign player to random element of players array
            if game_count == 0
                @player = players.sample 
            #If computer's player variable is set to 'guesser' and game_count is not 0,
            #set player to 'codemaker'
            elsif computer.player == 'guesser' && game_count != 0
                @player = 'codemaker'
            #If computer's player variable is set to 'codemaker' and game_count is not 0,
            #set player to 'guesser' 
            elsif computer.player == 'codemaker' && game_count != 0
                @player = 'guesser'
            end
        end
        #Create an instance method where the player variable can be read
        attr_reader :player
end
#Create a class called Computer
class Computer
#Inside the Computer class,
    def initialize(human)
        #Declare an instance variable called player
        @player
        #If computer's player variable is set to 'guesser',
        #set player to 'codemaker'
        if human.player == 'guesser'
            @player = 'codemaker'
        #If computer's player variable is set to 'codemaker',
        #set player to 'guesser' 
        elsif human.player == 'codemaker'
            @player = 'guesser'
        end
    end
    #Create an instance method where the player variable can be read
    attr_reader :player
end

puts Game.new.nominate_colours_guesser