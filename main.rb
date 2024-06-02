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
        #Create a human object passing in game_count and players array
        #Create a computer object passing in players array
        #Assign class variable number_of_games to class method set_number_of_games 
    #Create an instance method called set_num_of_games
    def set_num_of_games
        #Keep looping to allow the user to type in the input until the value is an integer,
        #is at least 2 and is even number
        loop do  
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
            end
        break if num_of_games.is_a?(Integer) == true && num_of_games >= 2 && num_of_games.even? == true
        end
    end
end
#Create a class called Human
    #Inside the Human class,
        #Declare an instance variable called player
        
        #If game_count is 0, then assign player to random element of players array
        
        #If computer's player variable is set to 'guesser' and game_count is not 0,
        #set player to 'codemaker'

        #If computer's player variable is set to 'codemaker' and game_count is not 0,
        #set player to 'guesser' 

        #Create an instance method where the player variable can be read

#Create a class called Computer
#Inside the Computer class,
        #Declare an instance variable called player
        
        #If computer's player variable is set to 'guesser',
        #set player to 'codemaker'

        #If computer's player variable is set to 'codemaker',
        #set player to 'guesser' 

        #Create an instance method where the player variable can be read