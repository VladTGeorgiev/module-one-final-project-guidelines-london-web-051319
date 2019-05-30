require_relative '../config/environment.rb'

   greeting
   username = gets.chomp

   user = User.find_by(username: username)
   if !user
      user = User.create(username: username)
   end

   puts "\n"
   puts "-- Hello, #{username}! --".colorize(:cyan)

   user_obj = Input.new(user.id)
   input(user_obj)
