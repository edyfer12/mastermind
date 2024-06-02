#Include require.colorize that would enable the font-colour and background-colour for the 
#string value

#Create a class called Game where rules are set, set number of games are played, colour patterns
#are created for the codemaker and guesser, play multiple games and decoding_board is both 
#printed and updated.
class Game 
    #Declare a class variable called number of games
    @@number_of_games
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