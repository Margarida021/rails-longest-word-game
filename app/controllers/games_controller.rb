require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
    # @letter = [*"a".."z"].sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = JSON.parse(URI.open(url).read)
    play = @word.chars.all? { |e| @letters.chars.include?(e) }
    @player_score = 0

    if response["found"] && play
      @result = "Congratulations! #{@word} is a valid english word!"
      @player_score = @word.length
    elsif response["found"] == false && play
      @result = "Sorry, but the word #{@word} is not an english word"
      @player_score = 10
    else
      @result = "Sorry, but the word #{@word} cannot be built out of the given words #{@letters}"
      @player_score
    end
  end
end
