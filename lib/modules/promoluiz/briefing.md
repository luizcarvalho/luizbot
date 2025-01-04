

`message_converter.rb` deve receber a MENSAGEM buscar pelo link encurtado amzn.to, expandir o link para o original. Deve usar a classe `amazon.rb` pra converter o link para o formato do afiliado correto e substituir o link orignal pelo novo.
o link is.gd deve ser totalmente substituido por `https://amzn.to/4fOOqSa`






## amazon.rb
```rb

class Amazon
  BASE_URL = 'https://www.amazon.com.br/gp/product/'
  AFL_SUFIX = '/tag=promoluiz-20'

  def initialize(link)
    @original_link = link
  end

  def self.amazon_url?(url)
    url[/amazon/]
  end

  def convert_link
    "#{BASE_URL}#{product_id}#{AFL_SUFIX}"
  end

  def product_id
    @original_link.match(%r{(?:product|dp)/(\w+)})&.captures&.first
  end
end

```

# MENSAGEM
```
WheyFit Parmalat! Super saboroso 😯

Parmalat WheyFit Pack Bebida Láctea Chocolate 15g de Proteína 250 Ml - 12 Unidades
🔥 R$ 68,81  parcelado

🛒Compre aqui: https://amzn.to/4fKH6al

✒ Seja prime e tenha acesso a vários benefícios da Amazon, inclusive frete grátis! O primeiro mês é gratuito :https://is.gd/t55rcy 
```