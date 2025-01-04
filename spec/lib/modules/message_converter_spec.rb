# spec/message_converter_spec.rb

RSpec.describe MessageConverter do
  describe '#convert' do
    let(:message_with_links) do
      <<~MSG
        WheyFit Parmalat! Super saboroso 😯

        Parmalat WheyFit Pack Bebida Láctea Chocolate 15g de Proteína 250 Ml - 12 Unidades
        🔥 R$ 68,81  parcelado

        🛒Compre aqui: https://amzn.to/4fKH6al

        ✒ Seja prime e tenha acesso a vários benefícios da Amazon, inclusive frete grátis! O primeiro mês é gratuito :https://is.gd/t55rcy#{' '}
      MSG
    end

    let(:message_without_links) { 'No links here, just plain text.' }
    let(:message_with_invalid_links) { 'Check this out: https://notareallink/abcd123.' }
    let(:expanded_amazon_link) { 'https://www.amazon.com.br/dp/4fKH6al' }
    let(:converted_amazon_link) { 'https://www.amazon.com.br/gp/product/4fKH6al/tag=promoluiz-20' }
    let(:predefined_isgd_link) { 'https://amzn.to/4fOOqSa' }

    before do
      allow_any_instance_of(MessageConverter).to receive(:expand_short_link).and_return(expanded_amazon_link)
      allow(Amazon).to receive(:amazon_url?).and_return(true)
    end

    context 'when the message contains valid links' do
      it 'replaces amzn.to links with converted affiliate links' do
        converter = MessageConverter.new(message_with_links)
        output = converter.convert

        expect(output).to include(converted_amazon_link)
        expect(output).not_to include('https://amzn.to/4fKH6al')
      end

      it 'replaces is.gd links with the predefined affiliate link' do
        converter = MessageConverter.new(message_with_links)
        output = converter.convert

        expect(output).to include(predefined_isgd_link)
        expect(output).not_to include('https://is.gd/t55rcy')
      end
    end

    context 'when the message contains no links' do
      it 'returns the original message unaltered' do
        converter = MessageConverter.new(message_without_links)
        output = converter.convert

        expect(output).to eq(message_without_links)
      end
    end

    context 'when the message contains invalid or unrecognized links' do
      it 'leaves invalid links unaltered' do
        converter = MessageConverter.new(message_with_invalid_links)
        output = converter.convert

        expect(output).to eq(message_with_invalid_links)
      end
    end

    context 'when the message contains both valid and invalid links' do
      let(:mixed_message) do
        <<~MSG
          Valid link: https://amzn.to/4fKH6al
          Invalid link: https://notareallink/abcd123
        MSG
      end

      let(:expected_output) do
        <<~MSG
          Valid link: #{converted_amazon_link}
          Invalid link: https://notareallink/abcd123
        MSG
      end

      it 'only replaces valid links and leaves invalid ones unchanged' do
        converter = MessageConverter.new(mixed_message)
        output = converter.convert

        expect(output).to eq(expected_output)
      end
    end
  end
end
