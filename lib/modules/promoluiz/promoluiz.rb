# frozen_string_literal: true

require_relative 'message_converter'

# require 'faraday'
# require 'faraday/digestauth'
# require 'json'

class Promoluiz
  DETECT_REGEX = /amzn/.freeze
  #   BASE_URL = 'https://promoluiz.herokuapp.com/'.freeze

  def initialize(message)
    @message = message
  end

  def converted_message
    converter = MessageConverter.new(@message)
    converter.convert
  end

  #   def fetch_converted_promocoes
  #     conn = Faraday.new BASE_URL
  #     conn.request(:digest, ENV['PROMOLUIZ_USERNAME'], ENV['PROMOLUIZ_PASSWORD'])

  #     response = conn.post(
  #       'promocoes.json',
  #       { "promocao": { "promotional_text": @message } }.to_json,
  #       'Content-Type' => 'application/json'
  #     )
  #     parse_body(response.body)
  #   end

  #   def parse_body(body)
  #     JSON.parse(body)
  #   rescue StandardError => e
  #     puts e.message
  #     { 'message_promocao' => e.message }
  #   end

  #   def message_versions
  #     converted_promocoes = fetch_converted_promocoes
  #     "```\n#{converted_promocoes['message_promocao']}\n```"
  #   end
end
