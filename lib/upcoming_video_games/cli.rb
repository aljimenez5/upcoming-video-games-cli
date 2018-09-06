class UpcomingVideoGames::CLI

  def initialize
    puts "Welcome to Video Games Release dates!"
    vgames = UpcomingVideoGames::Scraper.new("https://www.gamestop.com/collection/upcoming-video-games")
    vgames.scrape
  end

  def call
    puts "Here is a list of games released and to be released in 2018:"
    list_games
  end

  def list_games
    all_games = UpcomingVideoGames::Game.games
    sorted_games = all_games.sort_by {|game_obj| game_obj.release_date}
    sorted_games.each.with_index(1) do |game, index|
      puts "#{index}. #{game.name} | #{game.release_date}"
    end
  end

end



# puts "Welcome to upcoming video game release dates!"
#
# puts "Which month games would you like to see? (Sept, Oct, Nov, Dec, or All)"
# puts "On which gaming system/console?"
#  puts "Which month for upcoming games would you like to see? (September, October, November, December)"
# month = gets.strip
#
# puts "Choose number of game you would like to view more info on."
# OR puts "search with keyword"
# game_list = gets.strip
#
#
# puts "Would you like to see the list again?"
#   ##have them be able to go back to list at any point of the program by typing in "games list"
