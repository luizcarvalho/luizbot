require 'dotenv/load'
require 'telegram/bot'
require 'api-ai-ruby'

require_relative './lib/modules/modules'
require_relative './config/routes'
require_relative './lib/luiz_bot'
require_relative './lib/utils'


logger = Logger.new(STDOUT)

Telegram::Bot::Client.run(ENV['TELEGRAM_TOKEN'], logger: logger) do |bot|

  bot.listen do |message|
    # puts "#{message.from.first_name}[#{message.chat.id}]: #{message.text}"
    LuizBot::Router.dispatch(bot, message) if message.chat.id == ENV['OWNER_ID'].to_i
  end
end
