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

  #going to fix a few errors that I made and didn't catch before
  def self.scrape_game_details(game_url)
    game_page = Nokogiri::HTML(open(game_url))
      #creating if statements because not all game urls lead to the pages that have the same code
    details = []
    if game_url.include?("/collection")
      game_page.css("div.product").each do |game_choice|
        collection_link = "https://www.gamestop.com" + game_choice.css("div.product_image a").attribute("href").value
      end
      first_link = Nokogiri::HTML(open(collection_link))
      first_price = first_link.css("h3.ats-prodBuy-price").text
      first_console = first_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      first_description = first_link.css("p.productbyline").text.strip
      details << {:price => first_price, :console => first_console, :description => first_description}
    elsif game_url.include?("/browse")
      game_page.css("div.product.new_product").each do |game_choice|
        browse_link = "https://www.gamestop.com" + game_choice.css("a.ats-product-title-lnk").attribute("href").value.strip
      end
      second_link = Nokogiri::HTML(open(browse_link))
      second_price = second_link.css("h3.ats-prodBuy-price").text
      second_console = second_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      second_description = second_link.css("p.productbyline").text.strip
      details << {:price => second_price, :console => second_console, :description => second_description}
    else
      third_price = game_page.css("h3.ats-prodBuy-price").text
      third_console = game_page.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      third_description = game_page.css("p.productbyline").text.strip
      details << {:price => third_price, :console => third_console, :description => third_description}
    end
    UpcomingVideoGames::Game.add_game_details(details)
    #or return details
  end



end
