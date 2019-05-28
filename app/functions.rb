# CURATED
def print_curated_article_overview(user)
  puts "\n\n"
  puts "\nSelect article by typing its title"

  articles = Article.where(curated: true)
  curated_titles = []
  articles.each {|article| curated_titles << "#{article.title}"}

  usr_input = gets.chomp
  obj = articles.find {|article| article.title.downcase == usr_input.downcase }

  if obj.title.downcase == usr_input.downcase
    puts "\n\n"
    puts obj.title.upcase
    puts "\n"
    puts obj.overview.gsub("\n", "")
  else
   puts "Select article by typing its title"
    usr_input = gets.chomp
  end

  user.article_id = obj.id
end

def list_curated_articles
  articles = Article.where(curated: true)
  curated_titles = []
  articles.each_with_index {|article, index| curated_titles << "#{index+1}. #{article.title}"}

  puts "C U R A T E D  A R T I C L E S"
  puts "==============================\n\n"
  curated_titles.each do |title|
    ind = curated_titles.index(title)
    if ind % 3 == 0
      print "\n\n#{title}"
    else
      print "  #{title}"
    end
  end
end


# LONGEST OVERVIEW
def longest_article(article_id)
  nums = []
  Article.all.each {|article| nums << article.overview.length}
  largest = nums.sort.last

  article = Article.all.find {|article| article.overview.length == largest}

  puts article.title.upcase
  puts "\n\n"
  puts article.overview.gsub("\n","")

  article_id = article.id
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

def most_liked_article(most_liked_id)
  article = Article.find_by(id: most_liked_id)
  print_most_liked_overview(article)
end

def print_most_liked_overview(article)
  puts "\n\n"
  puts article.title.upcase
  puts "\n"
  puts article.overview.gsub("\n", "")
  puts "\n"
end

# Astronomy Info of the Day
def aiod
  url = "https://api.nasa.gov/planetary/apod?api_key=giSxdlW48Uaffgw7kHUbUnUOkmwUpZijYQhGe5ep"
  uri = URI.parse(url)
  data = Net::HTTP.get(uri)

  json = JSON.parse(data)

  puts "
    TITLE: #{json["title"].upcase!}'\n
    DATE: #{json["date"]}'\n
    OVERVIEW\n#{json["explanation"]}
  "
end

def add_to_fav(user)
  article_id = user.article_id
  user_id = user.user_id

  user_liked = Favourite.all.find {|fav| fav.article_id == article_id && fav.user_id == user_id}

  #binding.pry
  if !user_liked
    Favourite.create(article_id: user.article_id, user_id: user.user_id)
    puts "Added to your favourites"
  else
    puts "This is already in your collections of favourites"
  end
end

def remove_fav(article_id, user_id)
  puts "Are you sure you want to remove this article from your favourites? (y/n)"
  input = gets.chomp

  loop do
    if input == "y"
      Favourite.find_by(article_id: article_id, user_id: user_id).destroy
      puts "Article removed from favourites"
    elsif input == "n"
      puts "Article not removed from favourites"
      exit
    elsif input == "exit"
      exit
    else
      puts "Puts valid command or type exit to close"
      input = gets.chomp
    end
  end
end

def search_article(article_id)
  puts "Please enter an object's name:"
  searched_name = gets.chomp
  searched_name.downcase
  num1 = rand(1..10)
  num2 = rand(1..10)
  articles = Article.all.select {|article| article.title.include?(searched_name) }.slice(0,9)

  articles.each_with_index do |article, index|
    puts "#{index+1}. #{article.title.upcase}\n #{article.overview}"
  end

  puts "Choose the article that you would like to read by typing its number"
    article_number = gets.chomp.to_i - 1
    puts articles[article_number]
end

# def search
#   puts "Please enter an object's name:"
#   searched_name = gets.chomp
#   searched_name.downcase
#   # searched_article = Article.all.select {|article| article.title.downcase.include?(searched_name)}
#   # searched_article.map {|article| article.overview}
#   searched_article = Article.all.select {|article| article.title.downcase.include?(searched_name)}.map {|article| article.overview}
#   puts "How many articles would you like to read for the #{searched_name}?"
#   number_of_articles = gets.chomp.to_i - 1
#   searched_article[0..number_of_articles].each_with_index do |article, index|
#       puts "#{index + 1}. #{article}"
#       puts "\n"
#   end
# end

def favourites(user)
  user_id = user.user_id
  list = Favourite.all.select {|fav| fav.user_id == user_id}
  #binding.pry
  puts "F A V O U R I T E  A R T I C L E S"
  puts "==============================\n\n"

  article_arr = list.map {|fav| Article.find_by(id: fav.article_id)}

  article_arr.each_with_index {|article, index| puts "#{index+1}. #{article.title}"}

    puts "Choose the article that you would like to read by typing its number"
    article_number = gets.chomp.to_i - 1
    article = article_arr[article_number]
    puts article.overview
end

def help
  puts "'search' - give the option to search"
  puts "'add' - adds the object to the user's favourites list"
  puts "'remove' - removes the object from the user's favourites list"
  puts "'favourites' - user's current list of favourites"
  puts "'curated_articles' - lists a number of curated articles"
  puts "'total' - a full list of objects in the database"
  puts "'most liked' - prints out the object with the most entries in all users' favourites lists"
  puts "'best known' - prints out the object with the longest description"
  puts "'exit' - terminates the app"
end



# TODO"'my location is ...' - changes your curent location to a new entry"\n
# TODO"'from my location' - prints the top 5 objects visible from the choosen location"n