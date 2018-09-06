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
      self.new(game)
    end
  end

  def self.games
    @@games.sort_by {|game_obj| game_obj.release_date}
  end

  def self.add_game_details(details)
    details.each {|key, value| self.send(("#{key}="), value)}
  end

end
