require "open-uri"
require "nokogiri"
require "pry"
require "json"
require 'net/http'
require "require_all"
require "activerecord"

$LOAD_PATH.unshift('.')
require_relative "article_data/json_read_write.rb"
require_relative "article_data/planets.rb"
require_relative "article_data/comets.rb"
require_relative "article_data/meteors.rb"
require_relative "article_data/moons.rb"
require_relative "article_data/asteroids.rb"
require_relative "article_data/misc.rb"

# require "models/article.rb"
# require "models/favourite.rb"
# require "models/user.rb"
