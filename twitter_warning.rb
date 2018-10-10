require 'dotenv'
require 'twitter'

Dotenv.load

client = Twitter::Streaming::Client.new do |config|
config.consumer_key        = ENV["TWITTER_API_KEY"]
config.consumer_secret     = ENV["TWITTER_API_SECRET"]
config.access_token        = ENV["TWITTER_API_ACCESS_TOKEN"]
config.access_token_secret = ENV["TWITTER_API_ACCESS_TOKEN_SECRET"]
end

client.user do |object|
  case object
  when Twitter::Tweet
    puts "It's a tweet!"
  when Twitter::DirectMessage
    puts "It's a direct message!"
  when Twitter::Streaming::StallWarning
    warn "Falling behind!"
  end
end
