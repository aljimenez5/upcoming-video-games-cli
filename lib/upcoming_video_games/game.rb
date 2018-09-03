class UpcomingVideoGames::Game
  attr_accessor :name, :release_month, :release_date, :game_url, :console, :price, :description

  @@all = []

  def initialize(name = nil, release_month = nil, release_date = nil, game_url = nil)
    @name = name
    @release_month = release_month
    @release_date = release_date
    @game_url = game_url
    @@all << self
  end


  # def self.create_by_each_game(#scraped_games = UpcomingVideoGames::Scraper.scrape_page)
  #   scraped_games.each do |game|
  #     self.new(game)
  #   end
  # end

  def add_game_details()

  end

  def self.all
    @@all
  end

  def game_url
    Nokogiri::HTML(open(self.game_url))
    binding.pry
  end

end
