def curate_asteroids
  category = "asteroid"
  json_hash = read_hash
  planet_data = {}
  url = open("https://solarsystem.nasa.gov/asteroids-comets-and-meteors/asteroids/overview/")
  document = Nokogiri::HTML(url)

  date = get_date(document)
  overview = get_overview(document)

  hashify(planet_data, category, date, overview)

  json_hash["curated"] << planet_data
  write_to_json(json_hash)
end

curate_asteroids
