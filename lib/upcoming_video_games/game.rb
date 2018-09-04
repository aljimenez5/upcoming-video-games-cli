require 'pry'
class UpcomingVideoGames::Game
  attr_accessor :name, :release_date, :url, :console, :price, :description

  @@games = []

  def initialize(game_hash)
    scraped_games.each {|key, value| self.send(("#{key}="), value)}
    @@games << self
  end


  def self.create_by_each_game(scraped_games = UpcomingVideoGames::Scraper.scrape_page)
    scraped_games.each do |game|
      self.new(game_hash)
    end
  end

  # def add_game_details()
  # #this method will eventually pull from scraped data from Scraper class to add to object
  # end

  def self.games
    @@games
  end

  def self.list_games #Using this to call in cli
    @@games.each.with_index(1) do |game, index|
      puts "#{index}. #{game.name} | #{game.release_date}"
    end
  end

  def self.game_url #I intend for this to send game.url to the scraper class
    @@games.each do |game|
      UpcomingVideoGames::Scraper.scrape_game_details(game.url)
    end
  end

end
