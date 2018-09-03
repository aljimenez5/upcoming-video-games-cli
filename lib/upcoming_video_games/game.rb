class UpcomingVideoGames::Game
  attr_accessor :name, :release_month, :release_date, :console, :description

  @@all = []

  def initialize(scraped_game)
    scraped_game.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end


  def self.create_by_each_game(scraped_games = UpcomingVideoGames::Scraper.scrape_page)
    scraped_games.each do |game|
      self.new(game)
      binding.pry
    end
  end

  def self.all
    @@all
  end

end
