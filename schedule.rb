require 'dotenv/load'
require 'telegram/bot'
require_relative './lib/schedules/contas_scheduler'
require_relative './lib/schedules/page_watcher_scheduler'

bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
messages = []

contas_scheduler = ContasScheduler.new
page_watcher_scheduler = PageWatcherScheduler.new

messages << contas_scheduler.verify
messages << page_watcher_scheduler.verify

def send_message(bot, message)
  bot.api.send_message(chat_id: ENV['OWNER_ID'], text: message)
end

messages.each do |message|
  next unless message

  puts "Sending message:\n\n #{message}"
  send_message(bot, message)
end
