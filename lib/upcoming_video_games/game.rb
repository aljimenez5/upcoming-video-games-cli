require 'pry'
class UpcomingVideoGames::Game
  attr_accessor :name, :release_date, :url, :console, :price, :description

  @@games = []

  def initialize(game_hash)
    game_hash.each {|key, value| self.send(("#{key}="), value)}
    @@games << self
  end


  def self.create_by_each_game(scraped_games)
    scraped_games.each do |game|
      self.new(game) unless game[:release_date].end_with?("2019")
    end
  end

  def self.games
    @@games
  end

  # def self.game_url #I created this method to send the game.url to the scraper class to scrape
  #   @@games.each {|game| UpcomingVideoGames::Scraper.scrape_game_details(game.url)}
  # end

  def add_game_details(details)
    #or add_game_details(scraped_details = UpcomingVideoGames::Scraper.scrape_game_details(game_url))
    details.each {|key, value| self.send(("#{key}="), value)}
    #not working yet
  end

end
