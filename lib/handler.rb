=begin
  /set prisma placa `123123`\nrenavan `000000`
  /update prisma placa `123123`\nrenavan `000001`
  /list
  /get prisma
=end

module LuizBot

  class Handler

    @apiai_client = ApiAiRuby::Client.new(
      client_access_token: ENV['DIALOGFLOW_TOKEN']
    )


    def self.fetch_data(bot, message)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    end
    def self.send_data(bot, message)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    end
    def self.list_options(bot, message)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    end
    def self.update_data(bot, message)
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    end

    def self.default(bot, message)
      response = @apiai_client.text_request message.text
      text = response.dig(:result,:fulfillment,:messages).first[:speech] || 'opps'
      bot.api.send_message(
                             chat_id: message.chat.id,
                             text: text,
                             parse_mode: 'markdown'
                           )
    end


  end
end
