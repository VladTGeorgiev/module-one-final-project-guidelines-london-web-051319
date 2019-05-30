def curate_planets
  planets_arr = ["mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune", "pluto"]
  category = "planet"
  planets_info = []
  json_hash = {}

  planets_arr.each do |planet|
    planet_data = {}
    url = open("https://solarsystem.nasa.gov/planets/#{planet}/overview/")
    document = Nokogiri::HTML(url)

    date = get_date(document)
    overview = get_overview(document)

    hashify(planet_data, planet, date, overview)
    planets_info << planet_data
  end

  json_hash["curated"] = planets_info
  write_to_json(json_hash)
end

curate_planets
