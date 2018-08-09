require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)

get '/' do
    params["guess"] = nil
    guess = params["guess"]
    message, background = check_guess(guess, SECRET_NUMBER)
    erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :background => background}
end

def check_guess(guess, answer)
    input = guess.to_i
    diff = (input - answer)

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
    end

    return output, color
end