require 'nokogiri'
require 'open-uri'
require 'pry'

class UpcomingVideoGames::Scraper

  def self.scrape_first_page
    gamestop_page = Nokogiri::HTML(open("https://www.gamestop.com/collection/upcoming-video-games"))
    binding.pry
    scraped_games = []
    ## games are nested under month release_date
  end

end
