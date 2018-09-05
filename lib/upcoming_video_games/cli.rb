class UpcomingVideoGames::CLI

  def call
    #UpcomingVideoGames::Game.new ??
    puts "Welcome to upcoming video game release dates!"
    puts "Here is a list of upcoming Video Games:"
    list_games
  end

  def list_games
    UpcomingVideoGames::Game.list_games
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
