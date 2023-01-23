require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://rapidapi.p.rapidapi.com/stock/v2/get-holders?symbol=BTC-USD&region=US")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-host"] = 'apidojo-yahoo-finance-v1.p.rapidapi.com'
request["x-rapidapi-key"] = 'IFnxWw8V2TFDeMu7cSCuDAYobMjoQtfp'

response = http.request(request)
puts response.read_body



# require 'dotenv/load'
# require 'telegram/bot'

# START_HOUR = 8
# END_HOUR = 18

# quantidade = ENV["QUANTIDADE"].to_i || 660
# IOF = ENV["IOF"].to_f || 0.0638

# if START_HOUR <= Time.now.hour && Time.now.hour <= END_HOUR
#   response = Faraday.get ENV['CAMBIO_ENDPOINT']
#   euro_price = JSON.parse(response.body)['EUR']['RateToBRL'].to_f
#   bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])

#   resultado = "💶 EURO: R$ #{euro_price} \n"\
#               "🔢 Quantidade #{quantidade}\n"\
#               "#️⃣ Valor #{euro_price * quantidade} \n\n"\
#               "🔰 TOTAL: R$  #{((euro_price + (euro_price * IOF)) * quantidade).round(2)}"

#   bot.api.send_message(chat_id: ENV['OWNER_ID'], text: resultado)
# end
