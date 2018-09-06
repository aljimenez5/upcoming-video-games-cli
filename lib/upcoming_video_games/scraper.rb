class UpcomingVideoGames::Scraper

  attr_accessor :gamestop_page

  def initialize(url)
    @gamestop_page = Nokogiri::HTML(open(url))
  end

  def scrape
    self.scrape_page
  end

  def scrape_page
    scraped_games = []
    @gamestop_page.css("a.product_spot").each do |game|
      release_date = game.css("p span").text
      release_month = Date::MONTHNAMES[(Date.strptime(release_date, '%m/%d/%Y')).mon]
      release_year = (Date.strptime(release_date, '%m/%d/%Y')).year
      name = game.css("p").text.sub(release_date, '').strip
      url = "https://www.gamestop.com" + game.attribute("href").value
      scraped_games << {:name => name, :release_date => release_date, :release_month => release_month, :release_year => release_year, :url => url}
    end
    UpcomingVideoGames::Game.create_by_each_game(scraped_games)
  end

  def self.scrape_game_details(game, url)
    game_page = Nokogiri::HTML(open(url))
    details = {}
    if url.include?("/collection")
      game_page.css("div.product").each do |game_choice|
        @collection_link = "https://www.gamestop.com" + game_choice.css("div.product_image a").first.attribute("href").value
        first_link = Nokogiri::HTML(open(@collection_link))
        details[:price] = first_link.css("h3.ats-prodBuy-price").first.text.strip
        details[:console] = first_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
        details[:description] = first_link.css("p.productbyline").text.strip
        details[:purchase_link] = @collection_link
      end
    elsif url.include?("/browse")
      game_page.css("div.product.new_product").each do |game_choice|
        @browse_link = "https://www.gamestop.com" + game_choice.css("a.ats-product-title-lnk").first.attribute("href").value.strip
        second_link = Nokogiri::HTML(open(@browse_link))
        details[:price] = second_link.css("h3.ats-prodBuy-price").first.text.strip
        details[:console] = second_link.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
        details[:description] = second_link.css("p.productbyline").text.strip
        details[:purchase_link] = @browse_link
      end
    else
      details[:price] = game_page.css("h3.ats-prodBuy-price").first.text.strip
      details[:console] = game_page.css("li.ats-prodRating-platDet").text.sub('Platform:', '').strip
      details[:description] = !game_page.css("p.productbyline").text.strip.empty? ? game_page.css("p.productbyline").text.strip : game_page.css("div.longdescription.productbyline p").text.strip
      details[:purchase_link] = game.url
    end
    game.add_game_details(details)
  end


end
