require 'pry'
class UpcomingVideoGames::Game
  attr_accessor :name, :release_date, :url, :console, :price, :description

  @@games = []

  def initialize(game_hash)
    game_hash.each {|key, value| self.send(("#{key}="), value)}
    @@games << self
  end


  def self.create_by_each_game(scraped_games = UpcomingVideoGames::Scraper.scrape_page)
    scraped_games.each do |game|
      self.new(game)
    end
  end

  def self.games
    @@games
  end

  def self.list_games #Using this to call in cli
    @@games.each.with_index(1) do |game, index|
      puts "#{index}. #{game.name} | #{game.release_date}"
    end
  end

  def game_url #I created this method to send the game.url to the scraper class to scrape
    @@games.each {|game|
      UpcomingVideoGames::Scraper.scrape_game_details(game.url)}
  end

  def self.add_game_details(scraped_details = UpcomingVideoGames::Scraper.scrape_game_details(game_url))
    #now I am going to bring in the hashes of details from the Scraper class
    scraped_details.each {|key, value| self.send(("#{key}="), value)}
    binding.pry
    #not working yet
  end

end
