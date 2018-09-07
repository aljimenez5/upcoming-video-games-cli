class UpcomingVideoGames::Game
  attr_accessor :name, :release_date, :url, :console, :price, :description, :purchase_link

  @@games = []

  def initialize(game_hash)
    game_hash.each {|key, value| self.send(("#{key}="), value)}
    @@games << self
  end


  def self.create_by_each_game(scraped_games)
    scraped_games.each do |game|
      #write a comment to explain release year
      self.new(game) unless game[:release_date].between?(DateTime.new(2018, 1, 1), DateTime.new(2018, 9, 1))
    end
  end

  def self.games
    @@games.sort_by! {|game_obj| game_obj.release_date}
  end

  def add_game_details(details)
    details.each {|key, value| self.send(("#{key}="), value)}
    self
  end

end
