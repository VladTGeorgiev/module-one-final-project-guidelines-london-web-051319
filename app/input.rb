def input(userid)
    puts "Please enter a valid command or alternatively use the 'help' keyword for all options."
    user = Input.new(userid)
    loop do
      #binding.pry

      user_input = gets.chomp

      case user_input.downcase
      when 'add'
        add_to_fav(user)
      when 'remove'
        remove_fav(user)
      when 'favourites'
        favourites(user)
      when 'curated'
        list_curated_articles
        print_curated_article_overview(user)
      when 'search'
        search_article
      when 'most liked'
        most_liked_article
      when 'aiod'
        aiod
      when 'longest'
<<<<<<< HEAD
        longest
      when 'remove'
        remove_fav(user)
=======
        longest_article
>>>>>>> b7be1e40a2ba36226c6a5aecf24460ea97fa16fa
      when 'help'
        help
      when 'exit'
        exit
      else
        puts "Please enter a valid command or alternatively use the 'help' keyword for all options."
        #binding.pry
    end

  end

end
