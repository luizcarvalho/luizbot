require 'nokogiri'
require 'faraday'

# fetch GrowthSupplements page and observe changes
class GrowthPageWatcher
  attr_reader :doc

  WATCHED_PAGE = 'https://www.gsuplementos.com.br/creatina-250g-creapure-growth-supplements-p985824'.freeze
  # WATCHED_PAGE = 'https://www.gsuplementos.com.br/whey-protein-concentrado-1kg-growth-supplements-p985936'.freeze
  AVAILABLE_CLASS = '.botaoComprar'.freeze

  def initialize(available_class: AVAILABLE_CLASS)
    @doc = fetch_nokogiri_page
    @available_class = available_class
  end

  def verify
    doc.css(@available_class).any?
  end

  private

  def fetch_nokogiri_page
    response = Faraday.get(WATCHED_PAGE)

    @doc = Nokogiri::HTML(response.body)
  end
end

