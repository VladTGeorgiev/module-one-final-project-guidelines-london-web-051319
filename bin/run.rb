require_relative '../config/environment.rb'


greeting
username = gets.chomp
user = find_user(username)

user = sign_in(username, user)

puts "\n"
puts "  SI: -- Hello, #{username}! --".colorize(:cyan)
puts "  SI: -- I am Space Intelligence, or for short SI! I will be your host for your space journey today.".colorize(:cyan)
puts ""
user_obj = Input.new(user.id)
input(user_obj)
