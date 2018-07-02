require 'telegram/bot'
require 'api-ai-ruby'

token = '332044997:AAGuE9cJ6HR9scKbqcGHi9MvZVpgtFIzu0M'

client = ApiAiRuby::Client.new(
  client_access_token: 'd6e53ced20c14bb3ae197e9e03979d0c'
)
puts 'bot listen...'

def handle(bot, message, client)
  case message.text
  when '/start'
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
  when '/stop'
    bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
  else
    response = client.text_request message.text
    bot.api.send_message(chat_id: message.chat.id, text: response.dig(:result,:fulfillment,:messages).first[:speech])
  end
end

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts "#{message.from.first_name}[#{message.chat.id}]: #{message.text}"
    handle(bot, message, client) if message.chat.id == 51112220
  end
end
