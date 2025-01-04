require 'spec_helper'
require_relative '../../config/routes'
require_relative '../../lib/router'
require_relative '../../lib/handler'

RSpec.describe Routes do
  let(:bot) { double('bot') }
  let(:text_message) { double('text_message', text: message) }

  before do
    allow_any_instance_of(LuizBot::Handler).to receive(:fetch_data)
    allow_any_instance_of(LuizBot::Handler).to receive(:send_data)
    allow_any_instance_of(LuizBot::Handler).to receive(:list_options)
    allow_any_instance_of(LuizBot::Handler).to receive(:update_data)
    allow_any_instance_of(LuizBot::Handler).to receive(:amazon_promotion)
    allow_any_instance_of(LuizBot::Handler).to receive(:default)
  end

  context 'when message matches a route' do
    let(:message) do
      'Parmalat WheyFit Pack Bebida Láctea Chocolate 15g de Proteína 250 Ml - 12 Unidades 🔥 R$ 68,81  parcelado 🛒Compre aqui: https://amzn.to/4fKH6al'
    end

    it 'dispatches the correct action' do
      expect_any_instance_of(LuizBot::Handler).to receive(:amazon_promotion).with(bot, text_message)
      expect(Routes.dispatch(bot, text_message)).to be true
    end
  end

  context 'when message does not match any route' do
    let(:message) { 'This is a random message that does not match any route' }

    it 'dispatches the default action' do
      expect_any_instance_of(LuizBot::Handler).to receive(:default).with(bot, text_message)
      expect(Routes.dispatch(bot, text_message)).to be false
    end
  end
end
