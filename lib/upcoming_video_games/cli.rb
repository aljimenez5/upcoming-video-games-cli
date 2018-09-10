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
    input = ""
    while input != "exit"
      puts "TO EXIT ENTER: [exit]"
      puts "GAMES BY MONTH ENTER: [January, February, March...]"
      puts "GAME BY NUMBER ENTER: [Number Listed]"
      puts "Which game(s) would you like to see?"
      input = gets.strip
      if Date::MONTHNAMES.include?(input.capitalize)
        list_games_by_month(input.capitalize)
        puts "---------------------------------------"
        puts ""
      elsif (1..UpcomingVideoGames::Game.games.count).include?(input.to_i)
        get_more_details(input.to_i)
      elsif input == "list all games"
        list_all_games
      else
        puts "Invalid input" unless input == "exit"
      end
    end
  end

  def list_all_games
    all_games = UpcomingVideoGames::Game.games
    all_games.each.with_index(1) do |game, index|
      puts "#{index}. #{game.name} | #{game.release_date.strftime('%m/%d/%Y')}"
    end
  end

  def list_games_by_month(month_input)
    puts ""
    puts "-------------#{month_input}-----------------"
    UpcomingVideoGames::Game.games.each.with_index(1) do |game, index|
      if Date::MONTHNAMES[game.release_date.mon] == month_input
        puts "#{index}. #{game.name} | #{game.release_date.strftime('%m/%d/%Y')}"
      end
    end
  end

  def get_more_details(input)
    game = UpcomingVideoGames::Game.games[input - 1]
    if !game.instance_variable_defined?(:@price)
      UpcomingVideoGames::Scraper.scrape_game_details(game, game.url)
    end
    puts "-----------------------------------------"
    puts "#{game.name} | #{game.release_date.strftime('%m/%d/%Y')}"
    puts "#{game.console} | #{game.price}"
    puts ""
    puts "Purchase Here: #{game.purchase_link}"
    puts ""
    puts "#{game.description}"
    puts "-----------------------------------------"
    puts ""
    puts "TO SEE ALL GAMES ENTER: [list all games]"
  end

end
