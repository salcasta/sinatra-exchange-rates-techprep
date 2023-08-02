require "sinatra"
require "sinatra/reloader"

get("/") do
  require "http"
  currency_url = "https://api.exchangerate.host/symbols"
  raw_response = HTTP.get(currency_url)

  require "json"
  parsed_response = JSON.parse(raw_response)
  @symbols_hash = parsed_response.fetch("symbols")

  erb(:homepage)
end


get("/:main_curr") do
  @currency_choice = params.fetch("main_curr")

  require "http"
  response = HTTP.get('https://api.exchangerate.host/symbols')

  require "json"
  parsed_response = JSON.parse(response)

  @symbols_hash = parsed_response.fetch('symbols')

  erb(:currency_page)
end

get("/:main_curr/:secondary_curr") do
  @currency_one = params.fetch("main_curr")
  @currency_two = params.fetch("secondary_curr")

  require "http"
  convert_response = HTTP.get("https://api.exchangerate.host/convert?from=#{@currency_one}&to=#{@currency_two}")

  require "json"
  parsed_convert_response = JSON.parse(convert_response)

  @result_hash = parsed_convert_response.fetch('result')

  erb(:results)
end
