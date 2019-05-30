# USER UPDATE

def print_user_taken
  puts "\n"
  puts "-- This name is taken. Please choose another name. --".colorize(:magenta)
  puts "\n"
  print_press_enter
  puts "\n"
end

def print_user_saved(inp)
  puts "\n"
  puts "-- Your new name is #{inp} --".colorize(:cyan)
  puts "\n"
  print_press_enter
  puts "\n"
end

def save_user(user, inp)
  current_user = User.find_by(id: user.user_id)
  current_user.username = inp
  current_user.save
  print_user_saved(inp)
end

# CURATED ARTICLES
def print_curated_heading_and_titles(arr)
  puts "\n"
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "  -------------------------------------------------- C U R A T E D  A R T I C L E S ------------------------------------------------".colorize(:cyan)
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "\n"
  arr.each do |title|
    print " #{title}\n\n".colorize(:yellow)
  end
end

def print_longest_article_heading
  puts "\n"
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "  ---------------------------------------------------- L O N G E S T  A R T I C L E ------------------------------------------------".colorize(:cyan)
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "\n"
end

def print_article(article)
  puts "\n"
  puts "  TITLE: #{article.title.upcase}".colorize(:yellow)
  puts "\n"
  puts "  DATE: #{article.date.upcase}".colorize(:yellow)
  puts "\n"
  puts "  #{article.overview.gsub("\n","")}"
  puts "\n"
  puts "Press Enter For Main Menu".colorize(:cyan)
  puts "\n"
end

# MOST LIKED
def most_liked_num
  nums = []
  Article.all.each do |article|
    len = Favourite.where(article_id: article.id).size
    nums << len
  end
  nums.sort.last
end

def most_liked_id(most_liked_num)
  Article.all.each do |article|
    len = Favourite.where(article_id: article.id).size
    if len == most_liked_num
      return article.id
    end
  end
end

def print_most_liked_heading
  puts "\n"
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "  ------------------------------------------------- M O S T  L I K E D  A R T I C L E ----------------------------------------------".colorize(:cyan)
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "\n"
end

# Astro Info
def print_aiod_heading
  puts "\n"
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "  ------------------------------------------ A S T R O N O M Y  I N F O  O F  T H E  D A Y -----------------------------------------".colorize(:cyan)
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "\n"
end

def print_aiod_article(title, date, overview)
  puts "
  TITLE: #{title.upcase!}'\n
  DATE: #{date}".colorize(:yellow)
  puts "\n"
  puts "  #{overview}"
end

def parse_aiod_url
  url = "https://api.nasa.gov/planetary/apod?api_key=giSxdlW48Uaffgw7kHUbUnUOkmwUpZijYQhGe5ep"
  uri = URI.parse(url)
  data = Net::HTTP.get(uri)
  return JSON.parse(data)
end

def aiod_check_add_to_db(article, json, user)
  if !article
    new_article = Article.create(title: json["title"], date: json["date"], overview: json["explanation"], curated: false)
    user.article_id = new_article.id
    puts "\n"
  end
end

# ADD TO Favourite
def print_add_to_favourites
  puts "\n"
  puts "-- Added to your favourites --".colorize(:cyan)
  puts "\n"
  print_press_enter
end

def print_article_error
  puts "-- Cannot Add This Article --".colorize(:magenta)
  print_press_enter
end

def print_article_exist
  puts "\n"
  puts "-- This is already in your collections of favourites --".colorize(:magenta)
  puts "\n"
  print_press_enter
  puts "\n"
end

# REMOVE FROM Favourite

def print_are_you_sure
  puts "\n"
  puts "-- Are you sure you want to REMOVE this article from your favourites? (y/n) --".colorize(:magenta)
  puts "\n"
end

def print_article_removed
  puts "\n"
  puts "-- Article removed from favourites --".colorize(:magenta)
  puts "\n"
end

def print_article_not_removed
  puts "\n"
  puts "-- Article not removed from favourites --".colorize(:cyan)
  puts "\n"
end

def print_enter_valid_command
  puts "\n"
  puts "-- Enter valid command or type 0 to close --".colorize(:yellow)
  puts "\n"
end


# SEARCHs
def print_search_intro
  puts "\n"
  puts "-- Please enter the name of the object you would like to read about. --".colorize(:cyan)
  puts "\n"
end

def print_search_error
  puts "\n"
  puts "-- ERROR 404! No articles found with this search term --".colorize(:color => :yellow, :background => :red)
  puts "\n"
end

def search_logic(searched_name, article_arr, user)
  loop do
    if searched_name != "" && searched_name != "back"
      if !article_arr.empty?
        article_arr.each_with_index do |article, index|
          puts "\n"
          puts "  #{index+1}. #{article.title.upcase}\n".colorize(:yellow)
        end
        choose_by_number(article_arr, user)
        break
        else
          print_search_error
          print_press_enter
          break
      end
    elsif searched_name == "back"
      print_press_enter
      break
    else
      puts "\n"
      puts "Invalid search term -- try again or type back for main menu".colorize(:magenta)
      puts "\n"
      searched_name = gets.chomp
    end
  end
end

# favourites
def print_fav_heading
  puts "\n"
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "  ---------------------------------------------- F A V O U R I T E  A R T I C L E S ------------------------------------------------".colorize(:cyan)
  puts "  ==================================================================================================================================".colorize(:cyan)
  puts "\n"
end

# choose by number
def choose_by_number_error
  puts "\n"
  puts "-- No Articles in here :( Add some plox!!! --".colorize(:yellow)
  print_press_enter
  puts "\n"
end

def print_press_enter
  puts "\n"
  puts "-- Press Enter For Main Menu --".colorize(:cyan)
  puts "\n"
end

def greeting
  puts "\n"
  puts "
  ==================================================================================================================================

  ███████╗ ██████╗   █████╗   ██████╗ ███████╗    ████████╗ ██████╗   █████╗  ██╗   ██╗ ███████╗ ██╗      ██╗      ███████╗ ██████╗
  ██╔════╝ ██╔══██╗ ██╔══██╗ ██╔════╝ ██╔════╝    ╚══██╔══╝ ██╔══██╗ ██╔══██╗ ██║   ██║ ██╔════╝ ██║      ██║      ██╔════╝ ██╔══██╗
  ███████╗ ██████╔╝ ███████║ ██║      █████╗         ██║    ██████╔╝ ███████║ ██║   ██║ █████╗   ██║      ██║      █████╗   ██████╔╝
  ╚════██║ ██╔═══╝  ██╔══██║ ██║      ██╔══╝         ██║    ██╔══██╗ ██╔══██║ ╚██╗ ██╔╝ ██╔══╝   ██║      ██║      ██╔══╝   ██╔══██╗
  ███████║ ██║      ██║  ██║ ╚██████╗ ███████╗       ██║    ██║  ██║ ██║  ██║  ╚████╔╝  ███████╗ ███████╗ ███████╗ ███████╗ ██║  ██║
  ╚══════╝ ╚═╝      ╚═╝  ╚═╝  ╚═════╝ ╚══════╝       ╚═╝    ╚═╝  ╚═╝ ╚═╝  ╚═╝   ╚═══╝   ╚══════╝ ╚══════╝ ╚══════╝ ╚══════╝ ╚═╝  ╚═╝

  ==================================================================================================================================".colorize(:cyan)
  puts "\n"
  puts "
  ------------------------------------- Welcome SpaceTraveller! Please enter your username: ----------------------------------------".colorize(:cyan)
  puts "\n"
end

def choose_by_number(article_arr, user)
  puts "\n"
  puts "-- Choose the article that you would like to read by typing its number or press Enter to return to main menu --".colorize(:cyan)
  puts "\n"

  user_input = gets.chomp
  user_num = user_input.to_i
  len = article_arr.size
  article_iterator(user_num, len, article_arr, user)
end

def article_iterator(user_num, len, article_arr, user)
  loop do
    if user_num.is_a? Integer
      if user_num <= len && user_num > 0
        num = user_num - 1
        article = article_arr[num]
        user.article_id = article.id
        print_article(article)
        break if article
      elsif len == 0
        choose_by_number_error
        break
      else
        puts "\n-- Enter Value Between 1 and #{len} --".colorize(:magenta)
        user_input = gets.chomp
        user_num = user_input.to_i
      end
    end
  end
end

def menu_entry_0
  puts "\n"
  puts "|'0' - terminates the app".colorize(:cyan)
end

def menu_entry_1
  puts "\n"
  puts "|'1' - gives the option to search through all articles".colorize(:cyan)
end

def menu_entry_2
  puts "\n"
  puts "|'2' - adds the selected article to the user's favourites list".colorize(:cyan)
end

def menu_entry_3
  puts "\n"
  puts "|'3' - removes the selected article from the user's favourites list".colorize(:cyan)
end

def menu_entry_4
  puts "\n"
  puts "|'4' - user's current list of favourite articles".colorize(:cyan)
end

def menu_entry_5
  puts "\n"
  puts "|'5' - pulls an article from NASA's Astronomy Photo of the Day website about the featured photo".colorize(:cyan)
end

def menu_entry_6
  puts "\n"
  puts "|'6' - prints the article that has the most favourites".colorize(:cyan)
end

def menu_entry_7
  puts "\n"
  puts "|'7' - prints out the article with the longest description".colorize(:cyan)
end

def menu_entry_8
  puts "\n"
  puts "|'8' - lists a number of curated articles".colorize(:cyan)
end

def menu_entry_9
  puts "\n"
  puts "|'9' - to change your name".colorize(:cyan)
end
