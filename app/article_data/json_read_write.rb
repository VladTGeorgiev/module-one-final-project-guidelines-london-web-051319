def get_date(document)
  meta_tag = document.search("meta[property='og:updated_time']")
  meta_content = meta_tag.first.attributes.first
  meta_content[1].value.split(" ")[0]
end

def get_overview(document)
  div = document.css(".wysiwyg_content")
  overview = div.css("p").text
  binding.pry
  overview
end

def write_to_json(hash)
  File.open("../db/astronomy.json", "w") do |f|
    f.write(JSON.pretty_generate(hash))
  end
end

def read_hash
  JSON.parse(File.read("../db/astronomy.json"))
end

def hashify(hash, title, date, overview)
  hash["title"] = title.capitalize
  hash["date"] = date
  hash["overview"] = overview
  hash["curated"] = true
end
