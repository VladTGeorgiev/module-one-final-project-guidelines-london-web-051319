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
  puts article.title.upcase
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
  puts "=======================================\n\n"
  puts "\n"
end

# Astro Info
def print_aiod_heading
  puts "\n"
  puts "-- A S T R O N O M Y  I N F O  O F  T H E  D A Y --"
  puts "===================================================\n\n"
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
  puts "\n\n"
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
