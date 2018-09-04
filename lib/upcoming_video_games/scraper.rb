require 'pry'
class UpcomingVideoGames::Scraper

  def self.gamestop_page
    Nokogiri::HTML(open("https://www.gamestop.com/collection/upcoming-video-games"))
  end

  def self.scrape_page
    scraped_games = []
    gamestop_page.css("a.product_spot").each do |game|
      release_date = game.css("p span").text
      name = game.css("p").text.sub(release_date, '').strip
      url = "https://www.gamestop.com" + game.attribute("href").value
      scraped_games << {:name => name, :release_date => release_date, :url => url}
    end
    scraped_games
  end

  def self.scrape_game_details(game_url)
    game_page = Nokogiri::HTML(open(game_url))
      #creating if statements because not all game urls lead to the pages that have the same code
    details = []
    if game_url.include?("/collection")
      game_page.css("div.product").each do |game_choice|
        link = game_choice.css("div.product_image a").attribute("href").value
      end
      opened_link = Nokogiri::HTML(open(link))
      price = opened_link.css("h3.ats-prodBuy-price").text
      console = opened_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      description = opened_link.css("p.productbyline").text.strip
      details << {:price => price, :console => console, :description => description}
    elsif game_url.include?("/browse")
      game_page.css("div.product.new_product").each do |game_choice|
        link = game_choice.css("a.ats-product-title-lnk").attribute("href").value.strip
      end
      opened_link = Nokogiri::HTML(open(link))
      console = opened_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      description = opened_link.css("p.productbyline").text.strip
      details << {:price => price, :console => console, :description => description}
    else
      console = opened_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      description = opened_link.css("p.productbyline").text.strip
      details << {:price => price, :console => console, :description => description}
    end
    details
  end



end
