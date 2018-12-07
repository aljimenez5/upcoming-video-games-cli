class UpcomingVideoGames::Scraper

  attr_accessor :gamestop_page

  def initialize(url)
    @gamestop_page = Nokogiri::HTML(open(url))
  end

def scrape_page
    scraped_games = []
    @gamestop_page.css("a.product_spot").each do |game|
      date_string = game.css("p span").text.strip
      release_date = Date.strptime(date_string, '%m/%d/%Y') rescue nil
      name = game.css("p").text.sub(date_string, '').strip
      url = "https://www.gamestop.com" + game.attribute("href").value
      scraped_games << {:name => name, :release_date => release_date, :url => url}
    end
    UpcomingVideoGames::Game.create_by_each_game(scraped_games)
  end

  def self.scrape_game_details(game, url)
    game_page = Nokogiri::HTML(open(url))
    details = {}
    if url.include?("/collection")
      @collection_link = "https://www.gamestop.com" + game_page.css("div.product_image a").first.attribute("href").value
      first_link = Nokogiri::HTML(open(@collection_link))
      details[:price] = first_link.css("h3.ats-prodBuy-price").first.text.strip
      details[:console] = first_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      details[:description] = first_link.css("p.productbyline").text.strip
      details[:purchase_link] = @collection_link
    elsif url.include?("/browse")
      @browse_link = "https://www.gamestop.com" + game_page.css("a.ats-product-title-lnk").first.attribute("href").value.strip
      second_link = Nokogiri::HTML(open(@browse_link))
      details[:price] = second_link.css("h3.ats-prodBuy-price").first.text.strip
      details[:console] = second_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      details[:description] = second_link.css("p.productbyline").text.strip
      details[:purchase_link] = @browse_link
    else
      details[:price] = game_page.css("h3.ats-prodBuy-price").first.text.strip
      details[:console] = game_page.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      details[:description] = game_page.css("p.productbyline").text.strip
      details[:purchase_link] = game.url
    end
    game.add_game_details(details)
  end


end
