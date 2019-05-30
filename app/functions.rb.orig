# CURATED

def update_user(user)
  puts "-- Enter new title to change your name --"
  inp = gets.chomp
  loop do
    userExist = User.find_by(username: inp)
    if userExist
      puts "\n"
      puts "-- This name is taken. Please choose another name. --"
      puts "\n"
      puts "-- Press Enter For Main Menu --"
      puts "\n"
      inp = gets.chomp
    else
      current_user = User.find_by(id: user.user_id)
      current_user.username = inp
      current_user.save
      puts "\n"
      puts "-- Your new name is #{inp} --"
      puts "\n"
      puts "-- Press Enter For Main Menu --"
      puts "\n"
      break
    end
  end
end

def print_curated_article_overview(user)
  puts "\n\n"
  article_arr = Article.where(curated: true)
  curated_overview = []
  article_arr.each {|article| curated_overview << "#{article.overview}"}
  choose_by_number(article_arr, user)
end

def list_curated_articles
  articles = Article.where(curated: true)
  curated_titles = []
  articles.each_with_index {|article, index| curated_titles << "#{index+1}. #{article.title}"}

  puts "\n"
  puts "-- C U R A T E D  A R T I C L E S --"
  puts "====================================\n\n"

  curated_titles.each do |title|
    ind = curated_titles.index(title)
    print "#{title}\n\n"
  end
end


# LONGEST OVERVIEW
def longest_article(user)
  nums = []
  Article.all.each {|article| nums << article.overview.length}
  largest = nums.sort.last
  article = Article.all.find {|article| article.overview.length == largest}

  user.article_id = article.id

  puts "\n"
  puts "-- L O N G E S T  A R T I C L E --"
  puts "==================================\n\n"

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

def most_liked_article(most_liked_id, user)
  article = Article.find_by(id: most_liked_id)
  print_most_liked_overview(article, user)
end

def print_most_liked_overview(article, user)
  puts "\n"
  puts "-- M O S T  L I K E D  A R T I C L E --"
  puts "=======================================\n\n"
  puts "\n"
  puts article.title.upcase
  puts "\n"
  puts article.overview.gsub("\n", "")
  puts "\n"
  puts "Press Enter For Main Menu"
  puts "\n"

  user.article_id = article.id
end

# Astronomy Info of the Day
def aiod(user)
  url = "https://api.nasa.gov/planetary/apod?api_key=giSxdlW48Uaffgw7kHUbUnUOkmwUpZijYQhGe5ep"
  uri = URI.parse(url)
  data = Net::HTTP.get(uri)
  json = JSON.parse(data)
  puts "\n"
  puts "-- A S T R O N O M Y  I N F O  O F  T H E  D A Y --"
  puts "===================================================\n\n"
  puts "
    TITLE: #{json["title"].upcase!}'\n
    DATE: #{json["date"]}'\n
    OVERVIEW: \n\n #{json["explanation"]}\n
  "

  artExist = Article.find_by(title: json["title"])

  if !artExist
    new_article = Article.create(title: json["title"], date: json["date"], overview: json["explanation"], curated: false)
    user.article_id = new_article.id
    puts "\n"
  end
  user.article_id = artExist.id
  puts "\n"
end

def add_to_fav(user)
  article_id = user.article_id
  user_id = user.user_id

  user_liked = Favourite.all.find {|fav| fav.article_id == article_id && fav.user_id == user_id}
  if !user_liked && article_id
    Favourite.create(article_id: user.article_id, user_id: user.user_id)
    puts "\n"
    puts "-- Added to your favourites --"
    puts "\n"
    puts "\n\n"
    puts "-- Press Enter For Main Menu --"
  elsif !article_id
    puts "-- Cannot Add This Article --"
    puts "-- Press Enter For Main Menu --"
  else
    puts "\n"
    puts "-- This is already in your collections of favourites --"
    puts "\n\n"
    puts "-- Press Enter For Main Menu --"
    puts "\n"
  end
end

def remove_fav(user)
  article_id = user.article_id
  user_id = user.user_id
  puts "\n"
  puts "-- Are you sure you want to REMOVE this article from your favourites? (y/n) --"
  puts "\n"
  user_input = gets.chomp
  if user_input == "y"
    fav = Favourite.find_by(article_id: article_id, user_id: user_id)
    fav.destroy
    puts "\n"
    puts "-- Article removed from favourites --"
    puts "\n"
  elsif user_input == "n"
    puts "\n"
    puts "-- Article not removed from favourites --"
    puts "\n"
  elsif user_input == "0"
    exit
  else
    puts "\n"
    puts "-- Enter valid command or type exit to close --"
    puts "\n"
    user_input = gets.chomp
  end
  puts "-- Press Enter For Main Menu --"
  puts "\n"
end

def search(user)
  puts "\n"
  puts "-- Please enter the name of the object you would like to read about. --"
  puts "\n"
  searched_name = gets.chomp
  puts "\n"
  searched_name.downcase!
  article_arr = Article.all.select {|article| article.title.downcase.index(searched_name) }
  puts "\n"
  if !article_arr.empty?
    article_arr.each_with_index do |article, index|
      puts "#{index+1}. #{article.title.upcase}\n\n"
    end
    choose_by_number(article_arr, user)
    else
      puts "\n"
      puts "-- ERROR 404! No articles found with this search term --"
      puts "\n"
  end

end


def favourites(user)
  user_id = user.user_id
  list = Favourite.all.select {|fav| fav.user_id == user_id}
  article_arr = list.map {|fav| Article.find_by(id: fav.article_id)}
  puts "\n"
  puts "-- F A V O U R I T E  A R T I C L E S --"
  puts "========================================\n\n"
  article_arr.each_with_index {|article, index| puts "#{index+1}. #{article.title}\n\n"}
  choose_by_number(article_arr, user)
end

def help
  puts "\n"
  puts "|'0' - terminates the app"
  puts "\n"
  puts "|'1' - gives the option to search through all articles"
  puts "\n"
  puts "|'2' - adds the selected article to the user's favourites list"
  puts "\n"
  puts "|'3' - removes the selected article from the user's favourites list"
  puts "\n"
  puts "|'4' - user's current list of favourite articles"
  puts "\n"
  puts "|'5' - pulls an article from NASA's Astronomy Photo of the Day website about the featured photo"
  puts "\n"
  puts "|'6' - prints out the article with the most entries in all users' favourites lists"
  puts "\n"
  puts "|'7' - prints out the article with the longest description"
  puts "\n"
  puts "|'8' - lists a number of curated articles"
  puts "\n"
end

def choose_by_number(article_arr, user)
  puts "\n"
  puts "-- Choose the article that you would like to read by typing its number or press Enter to return to main menu --"
  puts "\n"

  user_input = gets.chomp
  user_num = user_input.to_i
  len = article_arr.size

  loop do
    if user_num.is_a? Integer
      if user_num <= len && user_num > 0
        num = user_num - 1
        article = article_arr[num]
        user.article_id = article.id
        puts "\n"
        puts article.title.upcase
        puts "\n"
        puts article.overview
        puts "\n\n"
        puts "-- Press Enter For Main Menu --"
        puts "\n"
        break if article
      elsif len == 0
        puts "-- No Articles in here :( Add some plox!!! --"
        puts "-- Press Enter For Main Menu --"
        puts "\n"
        break
      else
        puts "\n\n-- Enter Value Between 1 and #{len} --"
        user_input = gets.chomp
        user_num = user_input.to_i
      end
    end
  end
end
