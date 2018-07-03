require 'dotenv/load'
require 'telegram/bot'
require 'api-ai-ruby'

client = ApiAiRuby::Client.new(
  client_access_token: ENV['DIALOGFLOW_TOKEN']
)

logger = Logger.new(STDOUT)

def handle(bot, message, client)
  case message.text
  when '/start'
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
  when '/stop'
    bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
  else
    response = client.text_request message.text
    text = response.dig(:result,:fulfillment,:messages).first[:speech] || 'opps'
    bot.api.send_message(
                           chat_id: message.chat.id,
                           text: text,
                           parse_mode: 'markdown'
                         )
  end
end

Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN'], logger: logger) do |bot|
  bot.listen do |message|
    # puts "#{message.from.first_name}[#{message.chat.id}]: #{message.text}"
    handle(bot, message, client) if message.chat.id == ENV['OWNER_ID'].to_i
  end
end
