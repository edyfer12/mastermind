#Include require.colorize that would enable the font-colour and background-colour for the 
#string value

#Create a class called Game where rules are set, set number of games are played, colour patterns
#are created for the codemaker and guesser, play multiple games and decoding_board is both 
#printed and updated.

    #Declare a class variable called number of games

    #Create an instance method called set_num_of_games

        #Declare variable called num_of_games and set to input
        #Keep looping to allow the user to type in the input until the value is an integer,
        #is at least 2 and is even number
            #If num_of_games is not a number or includes non-numeric string, 
                #Display error "Not a number: Try Again"
            #If num_of_games is not an integer, but is a number, 
                #Display error "Not a whole number: Try Again"
            #If num_of_games is an integer, but is less than 2 or is not even number,
                #Convert to integer
                #Display error "Number has to be an even number at least 2: Try again"