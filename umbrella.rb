# I've already created a string variable above: pirate_weather_api_key
# It contains sensitive credentials that hackers would love to steal so it is hidden for security reasons.

require "http"

pp "Where are you located?"

user_location = gets.chomp.gsub(" ", "%20")

#user_location = "Chicago"
pp user_location

GMAPS_KEY = ENV.fetch("GMAPS_KEY")

google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + GMAPS_KEY

require "http"
resp = HTTP.get(google_maps_url)
raw_response = resp.to_s
require "json"
parsed_response=JSON.parse(raw_response)
pp parsed_response.keys

results = parsed_response.fetch("results")
first_result = results.at(0)
geometry = first_result.fetch("geometry")
loc = geometry.fetch("location")
pp latitude = loc.fetch("lat")
pp longitude = loc.fetch("lng")



PIRATE_WEATHER_API_KEY = ENV.fetch ("PIRATE_WEATHER_API_KEY")

# Assemble the full URL string by adding the first part, the API token, and the last part together
pirate_weather_url = "https://api.pirateweather.net/forecast/" + PIRATE_WEATHER_API_KEY + "/" +latitude.to_s+","+ longitude.to_s

# Place a GET request to the URL
raw_response = HTTP.get(pirate_weather_url)

require "json"

parsed_response = JSON.parse(raw_response)

currently_hash = parsed_response.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "The current temperature is " + current_temp.to_s + "."
