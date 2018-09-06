class UpcomingVideoGames::CLI

  def initialize
    puts "Welcome to Video Games Release dates!"
    vgames = UpcomingVideoGames::Scraper.new("https://www.gamestop.com/collection/upcoming-video-games")
    vgames.scrape
  end

  def call
    puts "Here is a list of games both released and to-be-released in 2018:"
    list_games
    more_details
  end

  def list_games
    all_games = UpcomingVideoGames::Game.games
    all_games.each.with_index(1) do |game, index|
      puts "#{index}. #{game.name} | #{game.release_date}"
      #puts "#{game.price}" ##this is just a test to see if the data is there
    end
  end

  def more_details
    puts "Type in the number listed next to the game you would like to view more info on:"
    selection = gets.strip
    all_games = UpcomingVideoGames::Game.games
    binding.pry
    # all_games.each.with_index(1) do |game, index|
    #   if selection == index
    #     binding.pry
    #     puts "#{index}. #{game.name} | #{game.release_date}"
    #     puts "#{game.console} | #{game.price}"
    #     puts "#{game.description}"
    #   end
    

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
