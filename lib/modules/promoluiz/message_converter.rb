# frozen_string_literal: true

require_relative '../amazon/amazon'
require 'net/http'
require 'uri'

class MessageConverter
  ISGD_REPLACEMENT = 'https://amzn.to/4fOOqSa'

  def initialize(message)
    @message = message
  end

  def convert
    updated_message = replace_amazon_links(@message)
    replace_isgd_links(updated_message)
  end

  private

  # Find and replace amzn.to links with the correct affiliate link
  def replace_amazon_links(message)
    message.gsub(%r{https://amzn\.to/\w+}) do |short_link|
      expanded_link = expand_short_link(short_link)
      if expanded_link && Amazon.amazon_url?(expanded_link)
        amazon = Amazon.new(expanded_link)
        amazon.convert_link
      else
        short_link # Fallback to original if not expandable
      end
    end
  end

  # Replace is.gd links with a fixed affiliate link
  def replace_isgd_links(message)
    message.gsub(%r{https://is\.gd/\w+}, ISGD_REPLACEMENT)
  end

  # Expand shortened links (e.g., amzn.to)
  def expand_short_link(short_link)
    uri = URI.parse(short_link)
    response = Net::HTTP.get_response(uri)
    return response['location'] if response.is_a?(Net::HTTPRedirection)

    nil
  rescue StandardError
    nil # Return nil if the expansion fails
  end
end
