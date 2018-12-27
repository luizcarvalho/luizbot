module Chatterbot
  module Client
        def client
            @client ||= Twitter::REST::Client.new(client_params.merge(tweet_mode: :extended))
            puts @client.inspect
            @client
        end
    end
end