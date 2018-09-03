class UpcomingVideoGames::Scraper

  def self.gamestop_page
    Nokogiri::HTML(open("https://www.gamestop.com/collection/upcoming-video-games"))
    ## games are nested under month release_date
  end

  def self.scrape_page
    @scraped_games = []
    self.gamestop_page.css("div.month").each do |month|
      release_month = month.css("h3").text
      self.gamestop_page.css("a.product_spot").each do |game|
        release_date = game.css("p span").text
        name = game.css("p").text.delete(release_date).strip
        url = "https://www.gamestop.com" + gamestop_page.css("a.product_spot").attr("href").text
        @scraped_games << {:name => name, :release_date => release_date, :release_month => release_month, :url => url}
        #UpcomingVideoGames::Game.new(scraped_games)
      end
    end
    @scraped_games
  end

  def self.scrape_game_details
    game_details = []

    second_page = Nokogiri::HTML(open(Game.url))

  end



end
