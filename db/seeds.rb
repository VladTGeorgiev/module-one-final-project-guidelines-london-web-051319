require "json"
require "pry"
require "faker"

file = File.read("db/astronomy.json")
json = JSON.parse(file)

# iterate through the categories and push them to the database
json.each do |key, data|
  data.each do |hash|
    title =  hash["title"]
    date =  hash["date"]
    overview =  hash["overview"]
    curated = hash["curated"]
    Article.create(title: title, date: date, overview: overview, curated: curated)
  end
end
# Create 10 Users
10.times { User.create(username: Faker::Name.name) }

Favourite.create(user_id: 1, article_id: 13)
Favourite.create(user_id: 2, article_id: 10)
Favourite.create(user_id: 1, article_id: 12)
Favourite.create(user_id: 13, article_id: 9)
Favourite.create(user_id: 1, article_id: 17)
Favourite.create(user_id: 1, article_id: 15)
Favourite.create(user_id: 1, article_id: 20)
