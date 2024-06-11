#Include require.colorize that would enable the font-colour and background-colour for the 
#string value
require "colorize"

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
        #@game_count = 0
        #Create a human object passing in game_count and players array
        @human = Human.new(PLAYERS)
        #Create a computer object passing in human
        @computer = Computer.new(@human)
        #else
        #@computer = Computer.new(@human)
        #@human = Human.new(game_count, PLAYERS)
        #end
        #Assign class variable number_of_games to class method set_number_of_games 
       # @@number_of_games = self.set_num_of_games
        #Create code_pegs array and store 'red', 'orange', 'pink', 'green', 'brown', 'yellow'.
        #Players can nominate the colour that exists in the code_pegs
        #@code_pegs = ['red', 'orange', 'pink', 'green', 'brown', 'yellow']
        #self.create_rules
        #self.nominate_colours_codemaker
        @board = Array.new(13, Array.new(12))
    end
    #Create an instance method called set_num_of_games
    def set_num_of_games
        #Keep looping to allow the user to type in the input until the value is an integer,
        #is at least 2 and is even number
        loop do  
            #Notify the user to enter the number of games
            print "Please enter the number of games: "
            #Declare variable called num_of_games and set to input
            num_of_games = gets.chomp.strip
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
            @blank = gets.chomp.downcase.strip
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
            @duplicate = gets.chomp.downcase.strip
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
            @code_pegs.push('blank')
        end
        #Create an array called codemaker
        @codemaker = []
        #If human is a codemaker and blank is activated to yes,
        if @human.player == 'codemaker' && @blank == 'yes'
            #Output to the user "Please enter the four colours (red, orange, green, pink, brown, yellow, blank):"
            puts "As a codemaker, please enter the four colours (coloured code pegs are red, orange, green, pink, brown, yellow, blank):"
        #If human is a codemaker and blank is activated to no,
        elsif @human.player == 'codemaker' && @blank == 'no'
            #Output to the user "Please enter the four colours (red, orange, green, pink, brown, yellow):"
            puts "As a codemaker, please enter the four colours (coloured code pegs are red, orange, green, pink, brown, yellow):"
        end
        #If the computer is a codemaker, invoke the method computer_make_code
        if @computer.player == 'codemaker'
            computer_make_code(@code_pegs, @duplicate)
        #Otherwise, invoke the method human_make_code
        else
            human_make_code(@code_pegs, @duplicate)
        end
        #Flatten the codemaker array by reassigning codemaker to codemaker invoked on built-in method flatten
        @codemaker = @codemaker.flatten
        puts "code_pegs: " + @code_pegs.to_s
        puts "codemaker: " + @codemaker.to_s
    end
    #Create instance method that enables the computer codemaker to nominate four colour patterns
    #passing in index of codemaker, code_pegs array and duplicate variable
    def computer_make_code(code_pegs, duplicate)
        #Create variable i and set i to 0 
        i = 0
        #Create variable codemaker_length and set to 4
        codemaker_length = 4
        #Loop from i to codemaker_length
        while i < codemaker_length
            #Create variable called randomValue and set to random value in code_pegs
            randomValue = code_pegs.sample
            #Use until loop to select random elements from code_pegs until duplicate value is set to 'Yes' 
            #or duplicate value is set to 'No' and element in codemaker does not exist
            until duplicate == 'yes' || (duplicate == 'no' && !@codemaker.include?(randomValue))
                #If duplicate value is set to 'No' and element in codemaker already exists then keep looping
                if duplicate == 'no' && @codemaker.include?(randomValue)
                    randomValue = code_pegs.sample
                end
            end
            #Push the randomValue to the codemaker array
            @codemaker.push(randomValue)
            i += 1
        end
    end
    #Create instance method that enables the human codemaker to nominate four colour patterns
    #passing in index of codemaker, code_pegs array and duplicate variable
    def human_make_code(code_pegs, duplicate)
        #Create variable called codemaker_valid_pattern and set to false
        codemaker_valid_pattern = false

        #Keep looping until all 4 strings are valid where all four strings exist in the code_pegs array and duplicate is set to yes 
        #or when four strings exist in the code_pegs array and are all unique to each other 
        
        while codemaker_valid_pattern == false  
            #Create variable colour, set to input and make it case insensitive
            colour = gets.chomp.strip.downcase

            #Convert the input into the array of strings so the compiler can spot if the string exists in code_peg array
            #and is a duplicate colour if the duplicate feature is enabled or disabled where array is sliced from index 0 to 3
            colour = colour.split
            #puts all_colours_exist?(code_pegs, colour) == 'false' && colour.length == 4 && duplicate == 'no' && has_duplicate?(colour) == 'false'
            case 
                #If one or more of the strings do not match the colours in the code_peg array out of 4 strings, then display the error message 'name_of_string(s)
                #does not exist: Try again' and encourage the user to enter input again
                when all_colours_exist?(code_pegs, colour) == 'false' && colour.length == 4 && 
                    (duplicate == 'yes' ||(duplicate == 'no' && has_duplicate?(colour) == 'false'))
                    puts "#{display_invalid_inputs} does not exist: Try again"
                #If one or more of the strings do not match the colours in the code_peg array out of 4 strings and duplicate is disabled
                #and has duplicate values, then display the error message
                when all_colours_exist?(code_pegs, colour) == 'false' && colour.length == 4 && duplicate == 'no' && has_duplicate?(colour) == 'true'
                    puts "#{display_invalid_inputs} does not exist and #{display_duplicate_colours} already typed: Try again"
                #If user enters less than 4 strings, duplicate is set to no, does not have duplicate colours and contains values
                #that do not exist, display error message as "Not enough colours and {name_of_invalid_colours} do not exist: Try again"
                when all_colours_exist?(code_pegs, colour) == 'false' && colour.length < 4 && duplicate == 'yes'  
                    puts "Not enough colours and #{display_invalid_inputs} does not exist: Try again"
                #If the user enters less than 4 strings but exist as code pegs and only one or more strings have duplicate colours 
                #in colour array when duplicate feature is disabled, notify the user "Not enough colours and {name_of_string(s)} are
                #duplicate colours" and encourage the user to type the input again
                when all_colours_exist?(code_pegs, colour) == 'true' && colour.length < 4 && has_duplicate?(colour) == 'true' && duplicate == 'no'
                    puts "Not enough colours and #{display_duplicate_colours} duplicate colours: Try again"
                #If the user enters less than 4 strings and only one or more strings have a combination of duplicate colours and 
                #and string that does not exist in colour array when duplicate feature is disabled, display error message
                when all_colours_exist?(code_pegs, colour) == 'false' && colour.length < 4 && duplicate == 'no' && has_duplicate?(colour) == 'true'
                    puts "Not enough colours, #{display_invalid_inputs} are invalid inputs and #{display_duplicate_colours} are 
                    duplicate colours: Try again" 
                
                #If one or more of the strings match the colour of the code_peg array but is a duplicate colour out of 4 strings, where the duplicate
                #feature is disabled, display error message 'name_of_string(s) is already typed: Try again' and encourage the user to 
                #type the input again
                when all_colours_exist?(code_pegs, colour) == 'true' && has_duplicate?(colour) == 'true' && duplicate == 'no' && colour.length == 4
                    puts "#{display_duplicate_colours} already typed: Try again".capitalize 
                #If the user enters less than 4 strings and all match the code_pegs array, notify the user "Not enough colours: Try Again"
                #encourage user to type the input again
                when all_colours_exist?(code_pegs, colour) == 'true' && colour.length < 4
                    puts "Not enough colours: Try again"
                #If the user enters less than 4 strings and only one or more strings do not exist in code_pegs array, notify the user
                #"Not enough colours and {name_of_string(s)} do not exist in code_pegs array" and encourage user to type the input again
                when all_colours_exist?(code_pegs, colour) == 'false' && colour.length < 4
                    puts "Not enough colours and #{display_invalid_inputs} do not exist as a code peg: Try again"
                #If the user enters more than 4 strings, display error message, "You can only select up to four colours: Try again"
                when (all_colours_exist?(code_pegs, colour) == 'false' || all_colours_exist?(code_pegs, colour) == 'true') && colour.length > 4
                    puts "You can only select up to four colours: Try again"
                else
                    codemaker_valid_pattern = true
            end
        end
            
        #Push the colour to the codemaker array
        @codemaker.push(colour)
    end
    #Create instance method that checks if all four colours of the input user typed exist in the code_pegs array regardless 
    #of the non-letter strings after the word. Return true if all the strings exist in the code_pegs array. Otherwise, return false
    def all_colours_exist?(code_pegs, colour)
        @invalid_inputs = []
        i = 0
        while i < colour.length
            if code_pegs.any?(colour[i]) == false
                @invalid_inputs.push(colour[i])
            end
            i += 1
        end
        if @invalid_inputs.length > 0
            #Make the invalid inputs array have unique values
            @invalid_inputs = @invalid_inputs.uniq
            return 'false'
        else
            return 'true'
        end
    end
    #Create an instance method that checks if the colour array has duplicate colours 
    def has_duplicate?(colour)
        #Create an instance array called duplicate_colours
        @duplicate_colours = []
        #Set i to 0
        i = 0
        #Loop through the colour array from index 0 to length - 1 of colour array
        while i < colour.length
            #For the individual element, check if it exists in the colour array more than once and 
            #exists in the code_pegs array except blank colour
            if colour.count(colour[i]) > 1 && @code_pegs.any?(colour[i])
                #If so, push the element inside the duplicate_colours array
                @duplicate_colours.push(colour[i])
            end
            #Increment i by 1
            i += 1 
        end
        #If duplicate_colours contain a value, make the values unique to each other and return true
        if @duplicate_colours.length > 0
            @duplicate_colours = @duplicate_colours.uniq
            return 'true'
        end
        #Otherwise return false  
        return 'false'
    end
    #Create an instance method where it converts the array into a string. If there is only one duplicate colour in the
    #array, just convert to an array. If there is more than one, join the elements with all commas and space except the last element
    def display_duplicate_colours
        #If length of array is just 1, then return just one value from the array 
        if @duplicate_colours.length == 1
            return @duplicate_colours[0] + " is"
        elsif @duplicate_colours.length > 1
        #Otherwise, convert the array to a string using " and " and retuurn the string
            return @duplicate_colours.join(' and ').to_s + " are"
        end
    end
    #Create an instance method where it converts the array of invalid inputs to a string. 
    def display_invalid_inputs
        #Create variable i and set to 0
        i = 0
        #Loop from i to length of invalid inputs 
        while i < @invalid_inputs.length 
        case 
        #If there is only one invalid input, then return one element. 
        when @invalid_inputs.length == 1
            return @invalid_inputs[0]
        #If there is two only invalid inputs, convert to string using the join method with " and " and return the value. 
        when @invalid_inputs.length == 2
            sentence = @invalid_inputs.join(' and ')
            return sentence
        #If there is three invalid inputs
        when @invalid_inputs.length > 2
            #slice the invalid inputs array that is index 0 and second last index and store into first_part_sentence
            first_part_sentence = @invalid_inputs.slice(0..@invalid_inputs.length - 2)
            #Convert first_part_senctence into a string with join method passing in ", " reassigned. 
            first_part_sentence = first_part_sentence.join(", ")
            #Concatenate " and " with last invalid inputs element extracted stored into second_part_sentence variable recently declared
            second_part_sentence = " and #{@invalid_inputs[@invalid_inputs.length - 1]}"
            #Return first_part_sentence added by second_part_sentence
            return first_part_sentence + second_part_sentence
        end
        i += 1
        end 
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
        #Create a local variable called points that is for setting points for the codemaker if a guesser has a turn
        #and set points to 0
        points = 0

        #Create variable guess_count and set to 0 to show the number of turns the guesser took
        guess_count = 0

        #Create variable called pattern_matched and set to 'false'
        pattern_matched = false

        #If human is a guesser and blank is activated to yes,
        if @human.player == 'guesser' && @blank == 'yes'
            #Output to the user "Please enter the four colours (red, orange, green, pink, brown, yellow, blank):"
            puts "As a guesser, please enter the four colours (coloured code pegs are red, orange, green, pink, brown, yellow, blank):"
        #If human is a codemaker and blank is activated to no,
        elsif @human.player == 'guesser' && @blank == 'no'
            #Output to the user "Please enter the four colours (red, orange, green, pink, brown, yellow):"
            puts "As a guesser, please enter the four colours (coloured code pegs are red, orange, green, pink, brown, yellow):"
            puts "You have #{MAX_GUESSES - guess_count} guesses left "
        end

        #Loop from guess_count to MAX_GUESSES as a way to check how many attempts the guesser made in choosing colours
        #and pattern_matched is set to 'false' meaning that no colours match in position and colour to the codemaker's
        while guess_count < MAX_GUESSES && !(pattern_matched == true)

            #Create an array called guesser that is used to store in four colours based on rules and assign to empty value
            #so the guesser can choose four colour patterns until they match the codemaker colour patterns
            guesser = []

            #Create counter variable colour_index and set to 0
            colour_index = 0

            if @human.player == 'guesser'
                #If human is a codemaker, then invoke the method human_guess_code passing in duplicate value and @code_pegs
                human_guess_colour(@duplicate, @code_pegs, guesser, guess_count)
            else
                #Otherwise, invoke the method computer_guess_code passing in duplicate value and @code_pegs
                computer_guess_colour(@duplicate, @code_pegs, guesser)
            end
            puts "Guesser: " + guesser.to_s
            puts "Feedback: " + @feedback.to_s
            #Add points by 1 so the codemaker gets rewarded each time the guesser nominates four colours in a pattern
            points += 1 

            #Check if the elements in feedback array is all black in colour. If so, terminate the loop by setting pattern_matched
            #to 'true'
            if @feedback.all?('black')
                pattern_matched = true
            end
            #If on the last row (MAX_GUESSES - 1) on the board the player does not get the last colour pattern correctly,
            #Add points by 1 which is a bonus point for the codemaker
            if guess_count == MAX_GUESSES - 1 && !@feedback.all?('black')
                points += 1
            end 

            #Increment guess_count by 1
            guess_count += 1
        end

        #If the computer is a codemaker, create an instance variable, computer_points and set to points
        if @computer.player == 'codemaker'
            @computer_points = points
        else
        #Otherwise, create an instance variable, human_points and set to points
            @human_points = points
        end

        ################################OLD CODE#######################################################
        #Create guesser_board variable that is a 2D array that store 12 rows and 4 columns
        #@guesser_board = Array.new(12, Array.new(4))
        #Create points variable and set to 0 so the codemaker earns points for each row guessed
        #points = 0
        #Create row variable and set to 0 to indicate the start of the turn for the guesser
        #row = 0
        #Loop through row to the MAX_GUESSES where the guesser makes 12 turns to get the pattern correctly
        #while row < MAX_GUESSES
            #Create col variable and set to 0 to indicate the start of choosing the colour
            #col = 0
            #Reset the whole array
            #@guesser_board = Array.new(12, Array.new(4))
            #Create feedback array where the guesser gets rewarded a key peg whenever the colour is selected
            #feedback = []
            #Output the instruction to the human guesser, "As a guesser please enter four colours (red, orange,
            #green, pink, brown, yellow):"
            #puts "As a guesser please enter four colours (coloured code pegs are red, orange, green, pink, brown, yellow):" if @human.player == 'guesser'
            #Loop through col to NUM_LARGE_HOLES so that the guesser is able to nominate four colours for each row
            #while col < NUM_LARGE_HOLES
                #If the computer is a guesser, then invoke the method called computer_guess_colour passing in feedback array, duplicate 
                #row and col to actively enable the computer to take turn choosing four colours and be rewarded key peg
                #if @computer.player == 'guesser'
                    #computer_guess_colour(feedback, @duplicate, row, col)
                #else
                #Otherwise, invoke the human_guess_colour passing feedback array, duplicate, row and col so that the human player can take turn choosing
                #four colours and be rewarded key peg
                    #human_guess_colour(feedback, @duplicate, row, col)
                #end
                #Add col by 1 as way of enabling the guesser to choose the next colour
                #col += 1
            ##end
            #Add points by 1 after col is set to 4 indicating that the guesser has taken the turn to guess four colours in a row.
            #The codemaker earns a point per row that the guesser chooses 4 colours
            #points += 1
            #If row is MAX_GUESSES - 1 and feedback row does not include all black colours, which is the last row for the guesser 
            #to take a turn, add points by 1 to show that the codemaker has earned 1 extra point
            #if row == MAX_GUESSES - 1 && !feedback.all?('black')
                #points += 1
            #end
            #If the feedback row contains all four black colours, terminate the outer loop so that there is no more guessing
            #if feedback.all?('black')
                #break
            #end
            #Add row by 1 so the guesser can take another turn selecting the new pattern of four colours
            #row += 1
        #end 
        #If the computer is a guesser, declare human_points variable and set to points
        #if @computer.player == 'guesser'
            #@human_points = points
        #Otherwise, declare computer_points variable and set to points
        #else
            #@computer_points == points
        #end
    ############################################################################################################
    end
    #Create instance method called computer_guess_colour where feedback and guesser arrays is passed so computer can  
    #choose colours based on the rules
    def computer_guess_colour(duplicate, code_pegs, guesser)
        #Create feedback array and set to []
        @feedback = []

        #Create variable i and set to 0
        i = 0
        #Create variable guesser_length and set to 4
        guesser_length = 4
        #Loop from i to guesser_length
        while i < guesser_length
            #Create a variable called random_value and set to random value selected from @code_pegs
            random_value = @code_pegs.sample
            #Keep selecting random values from until duplicate value is just set to 'yes' or duplicate value is 'no' and 
            #element chosen from code_pegs does not exist in the guesser array
            until duplicate == 'yes' || (duplicate == 'no' && code_pegs.include?(random_value))
                #Reassign random_value to random element selected from the array to allow the computer to repetitively select random 
                #colour from code_pegs until condition is met
                random_value = @code_pegs.sample
            end
            #Push random value into the guesser array
            guesser.push(random_value)
            #Flatten the guesser array
            guesser = guesser.flatten
            puts "Guesser[#{i}] = #{guesser[i]}"
            #puts "@codemaker.include?(guesser[i]) = #{@codemaker.include?(guesser[i])}"
            #If the guesser[i] does match both in colour and position to the codemaker, then push 'black' into feedback array
            if guesser[i] == @codemaker[i] && @codemaker.include?(guesser[i])
                @feedback.push('black')
            #If the guesser[i] does match in colour, not position and there are less specific or same duplicate colours in guesser than codemaker, 
            #then push 'white' into feedback array
            elsif guesser[i] != @codemaker[i] && @codemaker.include?(guesser[i]) &&
                guesser.count(guesser[i]) <= @codemaker.count(guesser[i])
                @feedback.push('white')
            #If the guesser[i] does not match in colour or specific number of duplicate colours is greater than in codemaker,
            #then push 'blank' 
            elsif !@codemaker.include?(guesser[i]) || (@codemaker.include?(guesser[i]) && 
                guesser.count(guesser[i]) > @codemaker.count(guesser[i]) && @codemaker[i] != guesser[i])
                @feedback.push('blank')
            end
            #Add i by 1
            i += 1
        end
        puts "feedback: " + @feedback.to_s
    ##############################################OLD CODE#########################################################
        #Create a variable called random_value and set to random element from code_pegs 
        #random_value = @code_pegs.sample
        #Keep looping until duplicate is 'yes' or duplicate is set to 'no' and random_value does not exist in guesser_board[row][col]
        #until duplicate == 'yes' || (duplicate == 'no' && !@guesser_board[row].include?(random_value))
            #If duplicate is set to 'no' and random_value exists in guesser_board, 
            #if duplicate == 'no' && @guesser_board[row].include?(random_value)
                #Reassign random_value to a new random element from code_pegs array so the rule is met when guessing the colour in the game
                #random_value = @code_pegs.sample
            #end
        #end
        ##Push the colour into the guesser_board[row] so that the nested array can keep track of the value stored
        #@guesser_board[row][col] = random_value
        #If the guesser_board[row][col] matches the colour and position in codemaker array, push 'black' into feedback array
        #if @codemaker.include?(@guesser_board[row][col]) && @codemaker[col] == @guesser_board[row][col]
            #feedback.push('black')
        #If the guesser_board[row][col] matches the colour, not position in codemaker array, and number of selected duplicate colours
        #in the guesser_board[row] is less than or equal to the codemaker's number of select duplicate colours, then push 'white' into
        #feedback array
        #elsif @codemaker.include?(@guesser_board[row][col]) && @codemaker[col] != @guesser_board[row][col] &&
            #@guesser_board[row].count(@guesser_board[row][col]) <= @codemaker.count(@guesser_board[row][col])
            #feedback.push('white')
        #If the guesser_board[row][col] does not have colour that exists in codemaker, or if colour does exist in codemaker, not match in 
        #position, but number of select duplicate colours in guesser_board[row] is greater than in codemaker, then push '' into feedback array
        #elsif !@codemaker.include?(@guesser_board[row][col]) || 
            #(@codemaker.include?(@guesser_board[row][col]) && @codemaker[col] != @guesser_board[row][col] &&
            #@guesser_board[row].count(@guesser_board[row][col]) > @codemaker.count(@guesser_board[row][col]))
            #feedback.push('blank')
        #end 
        ############################################################################################3
    end
    #Create instance method called human_guess_colour where feedback array, row, col and duplicate is passed so human can choose colours based 
    #on the rules    
    def human_guess_colour(duplicate, code_pegs, guesser, guess_count)
        #Create feedback array and set to []
        @feedback = []
        #Create a variable called colour and set to input
        colour = gets.chomp.strip.downcase
        #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
        #split passing in " " as an argument
        colour = colour.split

        #Create variable called guesser_valid_pattern and set to false
        guesser_valid_pattern = false

        #Keep looping until the guesser_valid pattern is set to true
        #puts all_colours_exist?(code_pegs, colour) == 'false' && colour.length == 4 && duplicate == 'no' && has_duplicate?(colour) == 'false'
        while !guesser_valid_pattern == true
        case 
            #If one or more of the strings do not match the colours in the code_peg array out of 4 strings, then display the error message 'name_of_string(s)
            #does not exist: Try again' and encourage the user to enter input again
            when all_colours_exist?(code_pegs, colour) == 'false' && colour.length == 4 && 
                (duplicate == 'yes' ||(duplicate == 'no' && has_duplicate?(colour) == 'false'))
                puts "#{display_invalid_inputs} does not exist: Try again"
                 #Create a variable called colour and set to input
                 colour = gets.chomp.strip.downcase
                 #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                 #split passing in " " as an argument
                 colour = colour.split
            #If one or more of the strings do not match the colours in the code_peg array out of 4 strings and duplicate is disabled
            #and has duplicate values, then display the error message
            when all_colours_exist?(code_pegs, colour) == 'false' && colour.length == 4 && duplicate == 'no' && has_duplicate?(colour) == 'true'
                puts "#{display_invalid_inputs} does not exist and #{display_duplicate_colours} already typed: Try again"
                 #Create a variable called colour and set to input
                 colour = gets.chomp.strip.downcase
                 #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                 #split passing in " " as an argument
                 colour = colour.split
            #If user enters less than 4 strings, duplicate is set to no, does not have duplicate colours and contains values
            #that do not exist, display error message as "Not enough colours and {name_of_invalid_colours} do not exist: Try again"
            when all_colours_exist?(code_pegs, colour) == 'false' && colour.length < 4 && duplicate == 'yes'  
                puts "Not enough colours and #{display_invalid_inputs} does not exist: Try again"
                 #Create a variable called colour and set to input
                 colour = gets.chomp.strip.downcase
                 #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                 #split passing in " " as an argument
                 colour = colour.split
            #If the user enters less than 4 strings but exist as code pegs and only one or more strings have duplicate colours 
            #in colour array when duplicate feature is disabled, notify the user "Not enough colours and {name_of_string(s)} are
            #duplicate colours" and encourage the user to type the input again
            when all_colours_exist?(code_pegs, colour) == 'true' && colour.length < 4 && has_duplicate?(colour) == 'true' && duplicate == 'no'
                puts "Not enough colours and #{display_duplicate_colours} duplicate colours: Try again"
                 #Create a variable called colour and set to input
                 colour = gets.chomp.strip.downcase
                 #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                 #split passing in " " as an argument
                 colour = colour.split
            #If the user enters less than 4 strings and only one or more strings have a combination of duplicate colours and 
            #and string that does not exist in colour array when duplicate feature is disabled, display error message
            when all_colours_exist?(code_pegs, colour) == 'false' && colour.length < 4 && duplicate == 'no' && has_duplicate?(colour) == 'true'
                puts "Not enough colours, #{display_invalid_inputs} are invalid inputs and #{display_duplicate_colours} are 
                duplicate colours: Try again" 
                 #Create a variable called colour and set to input
                 colour = gets.chomp.strip.downcase
                 #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                 #split passing in " " as an argument
                 colour = colour.split
            
            #If one or more of the strings match the colour of the code_peg array but is a duplicate colour out of 4 strings, where the duplicate
            #feature is disabled, display error message 'name_of_string(s) is already typed: Try again' and encourage the user to 
            #type the input again
            when all_colours_exist?(code_pegs, colour) == 'true' && has_duplicate?(colour) == 'true' && duplicate == 'no' && colour.length == 4
                puts "#{display_duplicate_colours} already typed: Try again".capitalize 
                 #Create a variable called colour and set to input
                 colour = gets.chomp.strip.downcase
                 #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                 #split passing in " " as an argument
                 colour = colour.split
            #If the user enters less than 4 strings and all match the code_pegs array, notify the user "Not enough colours: Try Again"
            #encourage user to type the input again
            when all_colours_exist?(code_pegs, colour) == 'true' && colour.length < 4
                puts "Not enough colours: Try again"
                 #Create a variable called colour and set to input
                colour = gets.chomp.strip.downcase
                #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                #split passing in " " as an argument
                colour = colour.split
            #If the user enters less than 4 strings and only one or more strings do not exist in code_pegs array, notify the user
            #"Not enough colours and {name_of_string(s)} do not exist in code_pegs array" and encourage user to type the input again
            when all_colours_exist?(code_pegs, colour) == 'false' && colour.length < 4
                puts "Not enough colours and #{display_invalid_inputs} do not exist as a code peg: Try again"
                 #Create a variable called colour and set to input
                colour = gets.chomp.strip.downcase
                #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                #split passing in " " as an argument
                colour = colour.split
            #If the user enters more than 4 strings, display error message, "You can only select up to four colours: Try again"
            when (all_colours_exist?(code_pegs, colour) == 'false' || all_colours_exist?(code_pegs, colour) == 'true') && colour.length > 4
                puts "You can only select up to four colours: Try again"
                 #Create a variable called colour and set to input
                colour = gets.chomp.strip.downcase
                #Convert colour string into an array by reassigning colour array to a colour string and calling the built in method
                #split passing in " " as an argument
                colour = colour.split
            else
                guesser_valid_pattern = true
                break
        end
       
    end
    puts "You have #{MAX_GUESSES - guess_count - 1} guesses left"
        #Push colour to guesser array
        guesser.push(colour)
        #Flatten the guesser array
        guesser = guesser.flatten
        #Create variable called guesser_index and set to 0
        guesser_index = 0
        #Loop from guesser_index to 4
        while guesser_index < 4
            #If guesser[i] has the same position and colour as the codemaker, then push 'black' on feedback array
            if guesser[guesser_index] == @codemaker[guesser_index] && @codemaker.include?(guesser[guesser_index])
                @feedback.push('black')
            #If guesser[i] has the same colour different position as the codemaker and number of specific duplicate
            #colours on guesser is less than or equal to the codemaker, then push 'white' on feedback array 
            elsif guesser[guesser_index] != @codemaker[guesser_index] && @codemaker.include?(guesser[guesser_index]) && 
                guesser.count(guesser[guesser_index]) <= @codemaker.count(guesser[guesser_index])
                @feedback.push('white')
            #If guesser[i] does not have colour on codemaker at all or has colour on different position where
            #number of specific duplicate colours on guesser is greater than of codemaker, push 'blank' on feedback array
            elsif !@codemaker.include?(guesser[guesser_index]) || (@codemaker.include?(guesser[guesser_index]) && 
                guesser.count(guesser[guesser_index]) > @codemaker.count(guesser[guesser_index]))
                @feedback.push('blank')
            end
            #Increment guesser_index by 1
            guesser_index += 1
        end
        ###############################OLD CODE##############################################################
        #Create a variable called colour and set to input
        #colour = gets.chomp
        #Keep looping until colour exists in code_pegs and (duplicate is 'yes' or duplicate is 'no' and colour does not exist in guesser_board[row]
        #until @code_pegs.include?(colour) && (duplicate == 'yes' ||  (duplicate == 'no' && !@guesser_board[row].include?(colour)))
            #If colour does not exist, display error message to the user "Colour does not exist as a code peg: Try again"
            #if !@code_pegs.include?(colour)
                #puts "Colour does not exist as a code peg: Try again"
            #end
            #If duplicate is 'no' and colour already exists in guesser_board[row], display error message "Cannot have duplicate colour in the guesser row: Try again"
            #if duplicate == 'no' && @guesser_board[row].include?(colour)
                #puts "Cannot have duplicate colour in the guesser row: Try again"
            #end
            #Reassign color to input
            #colour = gets.chomp
        #end
        #Push colour into the guesser_board[row] to keep track of the value stored in the nested array
        #@guesser_board[row][col] = colour
        #If the guesser_board[row][col] matches the colour and position in codemaker array, push 'black' into feedback array
        #if @codemaker.include?(@guesser_board[row][col]) && @guesser_board[row][col] == @codemaker[col]
            #feedback.push('black')
        #If the guesser_board[row][col] matches the colour, not position in codemaker array, and number of selected duplicate colours
        #in the guesser_board[row] is less than or equal to the codemaker's number of select duplicate colours, then push 'white' into
        #feedback array
        #elsif @codemaker.include?(@guesser_board[row][col]) && @guesser_board[row][col] != @codemaker[col] &&
            #@guesser_board[row].count(@guesser_board[row][col]) <= @codemaker.count(@guesser_board[row][col])
            #feedback.push('white')
        #If the guesser_board[row][col] does not have colour that exists in codemaker, or if colour does exist in codemaker, not match in 
        #position, but number of select duplicate colours in guesser_board[row] is greater than in codemaker, then push '' into feedback array 
        #elsif !@codemaker.include?(@guesser_board[row][col]) || 
            #(@codemaker.include?(@guesser_board[row][col]) && @guesser_board[row][col] != @codemaker[col] &&
            #@guesser_board[row].count(@guesser_board[row][col]) > @codemaker.count(@guesser_board[row][col]))
            #feedback.push('blank')
        #end
        #########################################################################################################
        #@guesser_board[row] = nil
#        puts "@gues2ser_board[#{row}] = #{@guesser_board[row]}"
    end
    #Create a decoding board that displays the asterisks in rows and columns up to date. The left and right hand side of the four
    #asterisks will have background colour of lightgrey. The middle section of the board indicates the colour pattern chosen 
    #by the guesser and codemaker. 
    def display_board
        #Create variable board_rows and set to 13 where the first row is for the codemaker and the next twelve rows are for the
        #guesser
        board_rows = 13
        #Create variable board_cols and set to 12 where the first and last four columns are the feedback provided for the human and computer
        board_cols = 12
        #Set row_index to 0
        row_index = 0
        #Loop from row_index to the board_rows
        while row_index < board_rows
            #Set col_index to 0
            col_index = 0
            #Loop from col_index to the board_cols
            while col_index < board_cols
                #If the row_index is 0,
                if row_index == 0
                    case 
                    #Set the first and last 4 columns to blank to show as a codemaker row
                    when col_index >= 0 && col_index <= 3 
                        @board[row_index][col_index] = '   '
                        print @board[row_index][col_index]
                    #Between the first 4 and middle section and last 4 columns and middle section, place | as a boundary
                    when col_index == 4
                        print "  || #{@board[row_index][col_index]} "
                    when col_index >= 5 && col_index <= 7
                        print " " + @board[row_index][col_index] + " "
                    when col_index == 8
                        @board[row_index][col_index] = '  '
                        print "|| " + @board[row_index][col_index]
                    else 
                        @board[row_index][col_index] = '  '
                        print @board[row_index][col_index]
                    end 
                    #Underneath place the equal signs as a separator between the last guesser row and codemaker row
                #If the row_index is greater than 0,
                else
                    if col_index == 0
                        print '||'
                    end
                    #At the first and last four columns, set background-color to lightgrey
                    if col_index >= 0 && col_index <= 3
                        @board[row_index][col_index] = @board[row_index][col_index].colorize( :background => :light_black)
                        print " ".colorize(:background => :light_black) + @board[row_index][col_index] + " ".colorize(:background => :light_black) 
                    #Between first and middle column and last and middle column, place | as a boundary
                    elsif col_index == 4
                        print "|| " + @board[row_index][col_index] + " "
                    #For the left hand side of the guesser_row, have the feedback row for the computer
                    elsif col_index >= 5 && col_index <= 7
                        print " " + @board[row_index][col_index] + " "
                    #For the right hand side of the guesser_row, have the feedback row for the human
                    elsif col_index == 8
                        @board[row_index][col_index] = @board[row_index][col_index].colorize( :background => :light_black)
                        print "||" + " ".colorize(:background => :light_black) + @board[row_index][col_index] + " ".colorize(:background => :light_black)
                    elsif col_index >= 9 && col_index <= 10
                        @board[row_index][col_index] = @board[row_index][col_index].colorize( :background => :light_black)
                        print " ".colorize(:background => :light_black) + @board[row_index][col_index] + " ".colorize(:background => :light_black)
                    else
                        @board[row_index][col_index] = @board[row_index][col_index].colorize( :background => :light_black)
                        print " ".colorize(:background => :light_black) + @board[row_index][col_index] + " ".colorize(:background => :light_black) + "||"
                    end
                end
                #Increment col_index by 1
                col_index += 1
            end
            if row_index == 0 || row_index == board_rows - 1
                puts "\n============================================"
            else
                puts
            end
            #Increment row_index by 1
            row_index += 1
            
        end
    end
    #Create instance method where the user plays multiple games of Mastermind
    def play_multiple_games
        #Declare game_count variable and set to 0
        game_count = 0
        #Declare code_pegs array and set to values
        @code_pegs = ['red', 'orange', 'pink', 'green', 'brown', 'yellow'] 
        #Assign class variable number_of_games to class method set_number_of_games 
        @@number_of_games = self.set_num_of_games
        #Loop from game_count through to the @@num_of_games class variable 
        #while game_count < @@number_of_games
            #Declare an Game object where the players are created where game_count is passe
            #Invoke the method, called create_rules
            create_rules
            #Invoke the method, called nominate_colours_codemaker
            nominate_colours_codemaker
            #Invoke the method, called nominate_colours_guesser
            nominate_colours_guesser
            #Increment game_count by 1
            #game_count += 1
        #end
        #Display the result of both computer and human players after selected number of games are played
    end
            
end
#Create a class called Human
class Human
    #Inside the Human class,
        def initialize(players)
            #Declare an instance variable called player
            #@player
            #If game_count is 0, then assign player to random element of players array
            #if game_count == 0
            @player = players.sample 
            #If computer's player variable is set to 'guesser' and game_count is not 0,
            #set player to 'codemaker'
            #elsif computer.player == 'guesser' && game_count != 0
               # @player = 'codemaker'
            #If computer's player variable is set to 'codemaker' and game_count is not 0,
            #set player to 'guesser' 
            #elsif computer.player == 'codemaker' && game_count != 0
               # @player = 'guesser'
            #end
        end
        #Create an instance method where the player variable can be read
        attr_accessor :player
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
    attr_accessor :player
end

Game.new.play_multiple_games