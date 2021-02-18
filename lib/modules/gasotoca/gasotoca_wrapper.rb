require 'gasotoca'

class GasotocaWrapper
  DETECT_REGEX = %r{/gasolina.*}.freeze

  def initialize(message)
    @message = message
  end

  def message
    ame
  end

  def ame
    temp_message = ''
    prices = Gasotoca.find(:gasoline, flag: 'BR', region: 'Região Sul')
    temp_message += "🏆 TOP 3 PREÇOS PROMOCIONAIS GASOLINA - REGIÃO SUL (Preço considerando cashback no AME)\n\n"
    prices = apply_discount(:gasoline, prices[1..3], 0.1)

    "#{temp_message}#{template(prices)}#{footer}"
  end

  def template(prices)
    prices.map do |price|
      "💲 R$ #{format('%.2f', price[:gasoline])}\n"\
      "⛽ [#{price[:flag]}] #{price[:name]}\n"\
      "📍 #{price[:address]}\n"
    end.join("\n")
  end

  def apply_discount(fuel, prices, discount)
    prices.map do |price|
      price[fuel] = price[fuel] * (1.0 - discount)
      price
    end
  end

  def footer
    "\n\n Fonte: #proconTO #PMWpromocoes"
  end
end
