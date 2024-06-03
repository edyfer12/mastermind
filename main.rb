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
        if @blank == 'Yes'
            code_pegs.push('')
        end
        #Create an array called codemaker
        @codemaker = []
        #Output to the user "Please enter the four colours (red, orange, green, pink, brown, yellow):"
        puts "Please enter the four colours (red, orange, green, pink, brown, yellow):"
        #Create variable i and set to 0
        i = 0
        #Keep entering the colours four times as a codemaker
        while(i < 4)
            #If the computer is a codemaker, invoke the method computer_make_code
            if @computer.player == 'codemaker'
                computer_make_code(i, @code_pegs, @duplicate)
            end
            #Otherwise, invoke the method human_make_code
            #Increment i by 1 to allow more colour to be entered
            i += 1
        end
    end
    #Create instance method that enables the computer codemaker to nominate four colour patterns
    #passing in index of codemaker, code_pegs array and duplicate variable
        #Use while loop to select random elements from code_pegs until duplicate value is set to 'Yes' 
        #or duplicate value is set to 'No' and element in codemaker does not exist
            #If duplicate value is set to 'No' and element in codemaker already exists then keep looping
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

puts Game.new.nominate_colours_codemaker