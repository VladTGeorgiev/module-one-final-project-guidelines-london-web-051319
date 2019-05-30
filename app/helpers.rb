# USER UPDATE

def print_user_taken
  puts "\n"
  puts "-- This name is taken. Please choose another name. --"
  puts "\n"
  print_press_enter
  puts "\n"
end

def print_user_saved(inp)
  puts "\n"
  puts "-- Your new name is #{inp} --"
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
  puts "-- C U R A T E D  A R T I C L E S --"
  puts "====================================\n\n"

  arr.each do |title|
    print "#{title}\n\n"
  end
end

def print_longest_article_heading
  puts "\n"
  puts "-- L O N G E S T  A R T I C L E --"
  puts "==================================\n\n"
end

def print_article(article)
  puts "\n"
  puts article.title.upcase
  puts "\n"
  puts article.date.upcase
  puts "\n"
  puts article.overview.gsub("\n","")
  puts "\n"
  puts "Press Enter For Main Menu"
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
  puts "-- M O S T  L I K E D  A R T I C L E --"
  puts "======================================="
  puts "\n"
end

# Astro Info
def print_aiod_heading
  puts "\n"
  puts "-- A S T R O N O M Y  I N F O  O F  T H E  D A Y --"
  puts "==================================================="
  puts "\n"
end

def print_aiod_article(title, date, overview)
  puts "
    TITLE: #{title.upcase!}'\n
    DATE: #{date}'\n
    OVERVIEW: \n\n #{overview}\n
  "
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
  puts "-- Added to your favourites --"
  puts "\n"
  print_press_enter
end

def print_article_error
  puts "-- Cannot Add This Article --"
  print_press_enter
end

def print_article_exist
  puts "\n"
  puts "-- This is already in your collections of favourites --"
  puts "\n\n"
  print_press_enter
  puts "\n"
end

# REMOVE FROM Favourite

def print_are_you_sure
  puts "\n"
  puts "-- Are you sure you want to REMOVE this article from your favourites? (y/n) --"
  puts "\n"
end

def print_article_removed
  puts "\n"
  puts "-- Article removed from favourites --"
  puts "\n"
end

def print_article_not_removed
  puts "\n"
  puts "-- Article not removed from favourites --"
  puts "\n"
end

def print_enter_valid_command
  puts "\n"
  puts "-- Enter valid command or type 0 to close --"
  puts "\n"
end


# SEARCHs
def print_search_intro
  puts "\n"
  puts "-- Please enter the name of the object you would like to read about. --"
  puts "\n"
end

def print_search_error
  puts "\n"
  puts "-- ERROR 404! No articles found with this search term --"
  puts "\n"
end

def search_logic(searched_name, article_arr, user)
  loop do
    if searched_name != "" && searched_name != "back"
      if !article_arr.empty?
        article_arr.each_with_index do |article, index|
          puts "#{index+1}. #{article.title.upcase}\n\n"
        end
        choose_by_number(article_arr, user)
        break
        else
          print_search_error
      end
    elsif searched_name == "back"
      print_press_enter
      break
    else
      puts "Invalid search term -- try again or type back for main menu"
      searched_name = gets.chomp
    end
  end
end

# favourites
def print_fav_heading
  puts "\n"
  puts "-- F A V O U R I T E  A R T I C L E S --"
  puts "========================================\n\n"
end

# choose by number

def choose_by_number_error
  puts "-- No Articles in here :( Add some plox!!! --"
  print_press_enter
  puts "\n"
end

def print_press_enter
  puts "\n"
  puts "-- Press Enter For Main Menu --"
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

  =================================================================================================================================="
  puts "\n"
  puts "-- Welcome SpaceTraveller! Please enter your username:-- "
  puts "\n"
end

def choose_by_number(article_arr, user)
  puts "\n"
  puts "-- Choose the article that you would like to read by typing its number or press Enter to return to main menu --"
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
        puts "\n\n-- Enter Value Between 1 and #{len} --"
        user_input = gets.chomp
        user_num = user_input.to_i
      end
    end
  end
end
