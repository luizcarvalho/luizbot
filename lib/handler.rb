=begin
  /set prisma placa `123123`\nrenavan `000000`
  /update prisma placa `123123`\nrenavan `000001`
  /list
  /get prisma
=end

module LuizBot

  class Handler
    def initialize
      @apiai_client = ApiAiRuby::Client.new(
        client_access_token: ENV['DIALOGFLOW_TOKEN']
      )

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

    def default(bot, message)
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
