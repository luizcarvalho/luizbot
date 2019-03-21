require_relative '../spec_helper'

RSpec.describe 'LuizBot::FirebaseService' do

  it 'does something' do
    firebase_service = LuizBot::FirebaseService.new
    expect(firebase_service.get('/get prisma')).to eq('754357')
  end
end