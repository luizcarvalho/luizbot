#!/usr/bin/env ruby

require 'rubygems'
require 'dotenv/load'
require 'twitter'


@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['LUNA_CONSUMER_KEY']
  config.consumer_secret     = ENV['LUNA_CONSUMER_SECRET']
  config.access_token        = ENV['LUNA_ACCESS_TOKEN']
  config.access_token_secret = ENV['LUNA_ACCESS_TOKEN_SECRET']
end

def retweet(tweet)
  @client.retweet(tweet.id)
    puts '⚫'
  rescue StandardError => e
    puts e.message
end

# ----------------------------------------------------------------------

words = ['chatbot', 'luna', 'inteligência artificial']

puts 'HOME'
@client.home_timeline.collect do |tweet|
  print '.'
  (retweet(tweet)  if words.any? { |s| tweet.text.include?(s) }) 
end

puts 'SEARCH'
@client.search("#chatbot -rt", lang: "pt-br", result_type: "recent").take(1).collect do |tweet|
  retweet(tweet)
end

