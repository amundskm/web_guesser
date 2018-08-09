require 'sinatra'
require 'sinatra/reloader'

    @@guesses = 5
    SECRET_NUMBER = rand(101)


    def check_guess(guess, answer)
        diff = (guess.to_i - answer)

        case
        when diff <= -5
            output = "Way too low."
            color = 'darkred'
        when (diff > -5) && (diff < 0)
            output = "Too low."
            color = 'red'
        when diff == 0
            output = "The SECRET NUMBER is #{answer}"
            color = 'green'
        when (diff > 0) && (diff < 5)
            output = "Too high."
            color = 'red'
        when diff >= 5
            output = "Way too high."
            color = 'darkred'
        else
            output = "That is not a valid guess."
            color = 'orange'
        end

        return output, color
    end

get '/' do
    first_line = "Enter your guess."
    background = 'white'
    guess = params["guess"]
    cheat = ""
    cheat = "Cheat: The answer is #{SECRET_NUMBER}" if params["cheat"]
    if guess != nil
        first_line, background = check_guess(guess, SECRET_NUMBER)
        @@guesses -= 1  
        if background == 'green'
            second_line = "A new number has been chosen"
            @@guesses = 5
            SECRET_NUMBER = rand(101)
            params["guess"] = nil
        elsif @@guesses == 0
            first_line = "End of the game, the answer was #{SECRET_NUMBER}"
            background = 'blue'
            @@guesses = 5
            SECRET_NUMBER = rand(101)
            params["guess"] = nil
        end  
        second_line = "You have #{@@guesses} guesses left."
    end
     

    erb :index, :locals => {:number => SECRET_NUMBER, :first_line => first_line, :second_line => second_line, :background => background, :cheat => cheat}
end