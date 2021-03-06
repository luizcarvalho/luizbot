require 'dotenv/load'
require 'telegram/bot'

START_HOUR = 8
END_HOUR = 18

quantidade = ENV["QUANTIDADE"].to_i || 660
IOF = ENV["IOF"].to_f || 0.0638

if START_HOUR <= Time.now.hour && Time.now.hour <= END_HOUR
  response = Faraday.get ENV['CAMBIO_ENDPOINT']
  euro_price = JSON.parse(response.body)['EUR']['RateToBRL'].to_f
  bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])

  resultado = "💶 EURO: R$ #{euro_price} \n"\
              "🔢 Quantidade #{quantidade}\n"\
              "#️⃣ Valor #{euro_price * quantidade} \n\n"\
              "🔰 TOTAL: R$  #{((euro_price + (euro_price * IOF)) * quantidade).round(2)}"

  bot.api.send_message(chat_id: ENV['OWNER_ID'], text: resultado)
end
