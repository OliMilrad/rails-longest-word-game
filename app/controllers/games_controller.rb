require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    @letters = (0..9).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @letters = params[:letters]
    @word = params[:answer]
    filepath = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_results = URI.open(filepath).read
    answers = JSON.parse(word_results)


    if @word.chars.all? { |letter| @word.downcase.count(letter.downcase) <= @letters.downcase.count(letter.downcase)} && answers["found"] == true
      @output = "Congratualtions, #{@word} is a valid word that can be built out of: #{@letters}"
    elsif @word.chars.all? { |letter| @word.downcase.count(letter.downcase) <= @letters.downcase.count(letter.downcase)} && answers["found"] == false
      @output = "Sorry but #{@word} is not an english word"
    else
      @output = "#{@word} cannot be built with #{@letters}"
    end
  end

end
