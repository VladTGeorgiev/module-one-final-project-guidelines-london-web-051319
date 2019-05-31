require_relative '../config/environment.rb'


greeting
username = gets.chomp

user = sign_in(username, user)

user_obj = Input.new(user.id)
input(user_obj)
 
