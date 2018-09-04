class UpcomingVideoGames::Scraper

  def self.gamestop_page
    Nokogiri::HTML(open("https://www.gamestop.com/collection/upcoming-video-games"))
  end

  def self.scrape_page
    scraped_games = []
    gamestop_page.css("div.month").each do |month|
      release_month = month.css("h3").text.sub('Releases', '').strip
      gamestop_page.css("a.product_spot").each do |game|
        release_date = game.css("p span").text
        name = game.css("p").text.sub(release_date, '').strip
        url = "https://www.gamestop.com" + gamestop_page.css("a.product_spot").attribute("href").text
        scraped_games << {:name => name, :release_month => release_month, :release_date => release_date, :url => url}
      end
    end
    scraped_games
  end

  def self.scrape_game_details(game_url)
    game_page = Nokogiri::HTML(open(game_url))
  end



end
