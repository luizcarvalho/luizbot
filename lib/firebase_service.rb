module LuizBot
  class FirebaseService
    INFO_TAG = 'info'.freeze

    def initialize
      @fbase = FBase.new
    end

    def push(text_message)
      data = convert_text_message(text_message)
      return 'FAIL' unless data
      response = @fbase.client.push(INFO_TAG, data)
      text_response(response)
    end

    def get(text_message)
      data = convert_text_message(text_message)
      return 'FAIL' unless data

      response = @fbase.client.get(INFO_TAG, { orderBy: "label", equalTo: data[:label]}.to_json)
      getting_value(response)
    end

    def list(text_message)
      response = @fbase.client.get(INFO_TAG)
      formatting_list(response)
    end

    def update(text_message)
      data = convert_text_message(text_message)
      return 'FAIL' unless data

      response = @fbase.client.set(INFO_TAG, data)
      text_response(response)
    end

    private


    def formatting_list(response)
      if response.success? && response.body&.keys
        response.body.map do |item_id, item|
          "`/get #{item['label']}`"
        end.join("\n")
      else
        "ERRO: #{response.code} "
      end

    end

    def getting_value(response)
      if response.success? && response.body&.values[0]&.dig('value')
        response.body.values[0]['value']
      else
        "Não encontrado: #{response.code} "
      end

    end


    def text_response(response)
      if response.success?
        'Salvo com sucesso'
      else
        "Erro ao salvar informação #{response.code}"
      end
    end

    def convert_text_message(text_message)
      result = text_message.scan(/^(\/\w*)\s*(\w*)\s*(.*)/)[0]
      return unless  result

      {label: result[1], value: result[2]}
    end

  # /set prisma placa `123123`\nrenavan `000000`
  # /update prisma placa `123123`\nrenavan `000001`
  # /list
  # /get prisma
  end
end