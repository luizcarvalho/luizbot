require 'dotenv/load'
require 'telegram/bot'

require_relative './lib/modules/modules'
require_relative './config/routes'
require_relative './lib/luiz_bot'
require_relative './lib/utils'

logger = Logger.new($stdout)

Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN'], logger: logger) do |bot|
  bot.listen do |message|
    if message
      puts "#{message.from.first_name}[#{message.chat.id}]: #{message.text}"
      LuizBot::Router.dispatch(bot, message) if (message.text != '') && (message.chat.id == ENV['OWNER_ID'].to_i)
    end
  end
end
