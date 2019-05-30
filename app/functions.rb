# CURATED
def update_user(user)
  puts "-- Enter new title to change your name --"
  inp = gets.chomp

  loop do
    userExist = User.find_by(username: inp)
    if userExist
      print_user_taken
      inp = gets.chomp
    else
      save_user(user, inp)
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

  print_curated_heading_and_titles(curated_titles)
end


# LONGEST OVERVIEW
def longest_article(user)
  nums = []
  Article.all.each {|article| nums << article.overview.length}
  largest = nums.sort.last
  article = Article.all.find {|article| article.overview.length == largest}

  user.article_id = article.id
  print_longest_article_heading
  print_article(article)
end


# MOST LIKED
def most_liked_article(most_liked_id, user)
  article = Article.find_by(id: most_liked_id)
  print_most_liked_overview(article, user)
end

def print_most_liked_overview(article, user)
  print_most_liked_heading
  print_article(article)
  user.article_id = article.id
end

# Astronomy Info of the Day
def aiod(user)
  json = parse_aiod_url
  print_aiod_heading
  print_aiod_article(json["title"], json["date"], json["explanation"])
  artExist = Article.find_by(title: json["title"])

  aiod_check_add_to_db(artExist, json, user)
  user.article_id = artExist.id
end

def add_to_fav(user)
  article_id = user.article_id
  user_id = user.user_id

  user_liked = Favourite.all.find {|fav| fav.article_id == article_id && fav.user_id == user_id}
  if !user_liked && article_id
    Favourite.create(article_id: user.article_id, user_id: user.user_id)
    print_add_to_favourites
  elsif !article_id
    print_article_error
  else
    print_article_exist
  end
end

def remove_fav(user)
  print_are_you_sure
  user_input = gets.chomp

  if user_input == "y"
    fav = Favourite.find_by(article_id: user.article_id, user_id: user.user_id)
    fav.destroy
    print_article_removed
  elsif user_input == "n"
    print_article_not_removed
  elsif user_input == "0"
    exit
  else
    print_enter_valid_command
    user_input = gets.chomp
  end
  print_press_enter

end

def search(user)
  print_search_intro
  searched_name = gets.chomp
  searched_name.downcase!
  article_arr = Article.all.select {|article| article.title.downcase.index(searched_name) }

  search_logic(searched_name, article_arr, user)
end


def favourites(user)
  user_id = user.user_id
  list = Favourite.all.select {|fav| fav.user_id == user_id}
  article_arr = list.map {|fav| Article.find_by(id: fav.article_id)}
  print_fav_heading

  article_arr.each_with_index {|article, index| puts "#{index+1}. #{article.title}\n\n"}
  choose_by_number(article_arr, user)
end

def help
  menu_entry_0
  menu_entry_1
  menu_entry_2
  menu_entry_3
  menu_entry_5
  menu_entry_6
  menu_entry_7
  menu_entry_8
  menu_entry_9
  puts "\n"
end
