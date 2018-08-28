require 'dotenv/load'
require 'telegram/bot'

START_HOUR = 8
END_HOUR = 18
<<<<<<< HEAD
quantidade = ENV["QUANTIDADE"].to_i || 660
IOF = ENV["IOF"].to_f || 0.0638

if START_HOUR <= Time.now.hour && Time.now.hour <= END_HOUR
  response = Faraday.get ENV['CAMBIO_ENDPOINT']
  euro_price = JSON.parse(response.body)['EUR']['RateToBRL'].to_f
  bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])

  resultado = "💶 EURO: R$ #{euro_price} \n"\
    "🔢 Quantidade #{quantidade}\n\n"\
    "#️⃣ Valor #{euro_price * quantidade} \n"\
    "📶 TOTAL #{(euro_price + (euro_price * IOF)) * quantidade} "

  bot.api.send_message(chat_id: ENV['OWNER_ID'], text: resultado)
end

=======

if START_HOUR <= Time.now.hour && Time.now.hour <= END_HOUR
  response = Faraday.get ENV['CAMBIO_ENDPOINT']
  euro_price = JSON.parse(response.body)['EUR']['RateToBRL']
  bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
  bot.api.send_message(chat_id: 51112220, text: " 💶 EURO: R$ #{euro_price}")
end
>>>>>>> 4264453dd3a960155abb53d8e060788ef3ca0c9e
