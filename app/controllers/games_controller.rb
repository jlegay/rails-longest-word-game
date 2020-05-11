require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    i = 0
    @letters = []
    while i < 10
      @letters << ("A".."Z").to_a.sample
      i+=1
    end
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    existing_word = user["found"]

    valid_word = true
    word_array = @word.upcase.split("")

    word_array.each do |letter|
      valid_word = false unless @letters.include?(letter)
    end


    @result = ""

    if valid_word
      if existing_word
        @result = "Congratulations #{@word} is a valid English word!"
      else
        @result = "Sorry but #{@word} does not seem to be a valid English word"
      end
    else
      @result = "Sorry but #{@word} can't be built out of #{@letters}"
    end

  end
end
