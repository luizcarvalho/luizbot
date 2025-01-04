require_relative '../../spec_helper'

RSpec.describe 'Amazon' do
  let(:amazon_link_product) { 'https://www.amazon.com.br/gp/product/B07YMBFYHF/ref=ppx_yo_dt_b_asin_title_o00_s00?ie=UTF8&psc=1' }
  let(:amazon_link_dp) { 'https://www.amazon.com.br/dp/857351549X/ref=s9_acsd_al_bw_c2_x_0_i' }
  describe 'product id' do
    it 'product link' do
      amazon = Amazon.new(amazon_link_product)
      expect(amazon.product_id).to eq('B07YMBFYHF')
    end

    it 'product dp' do
      amazon = Amazon.new(amazon_link_dp)
      expect(amazon.product_id).to eq('857351549X')
    end
  end

  describe 'convert_link' do
    it 'with affiliate_code' do
      amazon = Amazon.new(amazon_link_dp)
      expect(amazon.convert_link).to include('promoluiz')
    end
  end
end
