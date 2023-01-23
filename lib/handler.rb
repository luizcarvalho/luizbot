# frozen_string_literal: true
require_relative 'modules/amazon/amazon'

#   /set prisma placa `123123`\nrenavan `000000`
#   /update prisma placa `123123`\nrenavan `000001`
#   /list
#   /get prisma


module LuizBot
  class Handler
    def initialize
      @firebase = FirebaseService.new
    end

    def send_data(bot, message)
      result_message = @firebase.push(message.text)
      bot.api.send_message(chat_id: message.chat.id, text: result_message, parse_mode: 'markdown')
    end

    def fetch_data(bot, message)
      result_message = @firebase.get(message.text)
      bot.api.send_message(chat_id: message.chat.id, text: result_message, parse_mode: 'markdown')
    end

    def list_options(bot, message)
      result_message = @firebase.list(message.text)
      bot.api.send_message(chat_id: message.chat.id, text: result_message, parse_mode: 'markdown')
    end

    def update_data(bot, message)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    end

    def gasotoca(bot, message)
      gasotoca = GasotocaWrapper.new(message)

      send_message(
        bot, gasotoca.message
      )
    rescue StandardError => e
      puts e.backtrace
      send_message(bot, scape_text("ERROR: #{e.message}"))
    end

    def amazon_promotion(bot, message)
      promoluiz = Promoluiz.new(message.text)

      send_message(
        bot, promoluiz.message_versions
      )
    end

    def default(bot, message)
      text = 'Ainda não sou capaz de realizar uma ação para esse comando!'
      send_message(bot, text)
    rescue StandardError => e
      puts e.backtrace
      send_message(bot, scape_text("ERROR: #{e.message}\n\n#{e.backtrace.join("\n")}"))
    end

    def send_message(bot, text)
      bot.api.send_message(
        chat_id: ENV['OWNER_ID'].to_i,
        text: text,
        parse_mode: 'markdown'
      )
    end

    def scape_text(text)
      text.gsub(/[^0-9A-Za-z\s$]/, '')
    end
  end
end
