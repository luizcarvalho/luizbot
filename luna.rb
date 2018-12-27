#!/usr/bin/env ruby

require 'rubygems'
require 'dotenv/load'
require 'twitter'


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['LUNA_CONSUMER_KEY']
  config.consumer_secret     = ENV['LUNA_CONSUMER_SECRET']
  config.access_token        = ENV['LUNA_ACCESS_TOKEN']
  config.access_token_secret = ENV['LUNA_ACCESS_TOKEN_SECRET']
end

client.home_timeline.collect do |tweet|
  client.retweet(tweet.id)  if tweet.text =~ /chatbot/
end
