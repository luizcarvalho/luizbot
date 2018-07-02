require 'dotenv/load'
require 'telegram/bot'

response = Faraday.get ENV['CAMBIO_ENDPOINT']
euro_price = JSON.parse(response.body)['EUR']['RateToBRL']
bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
bot.api.send_message(chat_id: 51112220, text: " 💶 EURO: R$ #{euro_price}")