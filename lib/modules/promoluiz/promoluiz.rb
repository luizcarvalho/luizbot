require 'faraday'
require 'json'

class Promoluiz
  DETECT_REGEX = /(https:.*promosdodia.*)/.freeze
  BASE_URL = 'https://promoluiz.herokuapp.com/'.freeze

  def initialize(message)
    @message = message
  end

  def fetch_converted_promocoes
    conn = Faraday.new BASE_URL
    conn.basic_auth('luizcarvalho', 'swordfish1pr')

    response = conn.post(
      'promocoes.json',
      { "promocao": { "promotional_text": @message } }.to_json,
      'Content-Type' => 'application/json'
    )

    JSON.parse(response.body)
  end

  def message_versions
    converted_promocoes = fetch_converted_promocoes
    "```#{converted_promocoes['message_promocao']}```"
    # "```#{converted_promocoes['message_amazon']}```\n\n#{'🔹' * 10}\n\n ```#{converted_promocoes['message_promocao']}```"
  end
end
