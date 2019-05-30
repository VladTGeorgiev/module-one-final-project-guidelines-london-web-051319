require_relative '../config/environment.rb'

   greeting
   username = gets.chomp

   user = User.find_by(username: username)
   if !user
      user = User.create(username: username)
   end

   puts "\n"
   puts "  SI: -- Hello, #{username}! --".colorize(:cyan)
   puts "  SI: -- I am Space Intelligence, or for short SI! I will be your host for your space journey today.".colorize(:cyan)
   puts ""
   user_obj = Input.new(user.id)
   input(user_obj)

