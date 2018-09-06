class UpcomingVideoGames::CLI

  def initialize
    puts "Welcome to Video Games Release dates!"
    vgames = UpcomingVideoGames::Scraper.new("https://www.gamestop.com/collection/upcoming-video-games")
    vgames.scrape
  end

  def call
    puts ""
    puts "Here is the list of upcoming video games:"
    puts ""
    list_all_games
    puts ""
    puts "GAMES BY MONTH ENTER: [January, February, March...]"
    puts "GAME BY NUMBER ENTER: [Number Listed]"
    input = ""
    while input != "exit"
      puts "What game(s) would you like to see?"
      input = gets.strip
      case input
      when input =~ /\w/
        list_games_by_month(input.capitalize)
      when input =~ /\d/
        get_more_details(input.to_i)
      when input.to_i > UpcomingVideoGames::Game.games.count || UpcomingVideoGames::Game.games.each {|game| game.release_month == input}
        puts "Invalid input."
      when input
        
      end
    end
  end

  def list_all_games
    all_games = UpcomingVideoGames::Game.games
    all_games.each.with_index(1) do |game, index|
      puts "#{index}. #{game.name} | #{game.release_date}"
    end
    binding.pry
  end

  def list_games_by_month(input)
    UpcomingVideoGames::Game.games.each.with_index(1) do |game, index|
      puts "------#{input}------"
      if game.release_month == month_input
        puts "#{game.release_month}"
        puts "#{index}. #{game.name} | #{game.release_date}"
      end
    end
  end

  def get_more_details
    puts "Type in the number listed next to the game you would like to view more info on:"
    selection = gets.strip
    all_games = UpcomingVideoGames::Game.games
    all_games.each.with_index(1) do |game, index|
      if selection == index
        binding.pry
        puts "#{index}. #{game.name} | #{game.release_date}"
        puts "#{game.console} | #{game.price}"
        puts "#{game.description}"
      end
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
