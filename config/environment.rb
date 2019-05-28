require 'bundler'
require "open-uri"
require "json"
require "net/http"

Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_relative '../app/functions.rb'
require_relative '../app/user_input.rb'
require_relative '../app/input.rb'
