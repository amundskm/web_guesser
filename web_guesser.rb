require 'sinatra'
require 'sinatra/reloader'

number = rand(101)
get '/' do
    params["guess"] = nil
    guess = params["guess"]
    message = check_guess(guess, number)
    erb :index, :locals => {:number => number, :message => message}
end

def check_guess(guess, answer)
    input = guess.to_i
    diff = (input - answer).abs
    if  input < answer
        (diff > 5)? (message = "Way too low.") : (message = "Too low.")
    elsif input > answer
        (diff > 5)? (message = "Way too high.") : (message = "Too high.")
    elsif input == answer
        message = "The SECRET NUMBER is #{answer}"
    else
        message = "That is not a valid guess."
    end
end