class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(chr)
    
    if chr.nil? or chr.empty? or not chr.match(/[^[:alpha:]]/).nil?
      raise ArgumentError.new() 
      return false
    else
      chr.downcase!
      
      if @guesses.include? chr
        return false
      end
      
      if @wrong_guesses.include? chr
        return false
      end
      
      if @word.include? chr 
        @guesses += chr
      else
        @wrong_guesses += chr
      end
    end
    return true;
  end
  
  def word_with_guesses
    if @guesses.empty?
      @word.gsub(/./, '-')
    else
      @word.gsub(/[^#{@guesses}]/, '-')
    end
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end
end
