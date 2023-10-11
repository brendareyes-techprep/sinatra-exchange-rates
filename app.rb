require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  result = HTTP.get('https://api.exchangerate.host/symbols')

  parsed_result = JSON.parse(result)

  @curr = parsed_result.fetch('symbols')
  
  erb(:first)
end

get("/:currency") do
  @selected_curr = params.fetch("currency")

  result = HTTP.get('https://api.exchangerate.host/symbols')

  parsed_result = JSON.parse(result)

  @currencies = parsed_result.fetch('symbols')

  erb(:symbol)
end

get("/:curr1/:curr2") do
  @symbol1 = params.fetch("curr1")
  @symbol2 = params.fetch("curr2")
  convert_result = HTTP.get("https://api.exchangerate.host/convert?from=#{@symbol1}&to=#{@symbol2}")

  parsed_convert_result = JSON.parse(convert_response)

   @rate = parsed_convert_result.fetch('result')

  erb(:conversion)
end
