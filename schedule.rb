require 'dotenv/load'
require 'telegram/bot'

START_HOUR = 8
END_HOUR = 18

if START_HOUR <= Time.now.hour && Time.now.hour <= END_HOUR
  response = Faraday.get ENV['CAMBIO_ENDPOINT']
  euro_price = JSON.parse(response.body)['EUR']['RateToBRL']
  bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
  bot.api.send_message(chat_id: 51112220, text: " 💶 EURO: R$ #{euro_price}")
end
