require 'dotenv'
require 'twitter'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_API_KEY"]
  config.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config.access_token        = ENV["TWITTER_API_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_API_ACCESS_TOKEN_SECRET"]
end

client_s = Twitter::Streaming::Client.new do |config_s|
  config_s.consumer_key        = ENV["TWITTER_API_KEY"]
  config_s.consumer_secret     = ENV["TWITTER_API_SECRET"]
  config_s.access_token        = ENV["TWITTER_API_ACCESS_TOKEN"]
  config_s.access_token_secret = ENV["TWITTER_API_ACCESS_TOKEN_SECRET"]
end


puts "Choisissez en tapant le numéro associé:"
puts "1 - Voir son fil d'actualité"
puts "2 - Voir ses mentions"
puts "3 - Voir ses amis"
puts "4 - Tweeter"
puts "5 - Voir ses Tweets et Re-Tweets"
puts "0 - Quitter"

menu = gets.chomp

case menu
when "1"
  client.home_timeline.collect do |tweet|
    puts "#{tweet.text}"
    puts "\n Tweet de: #{tweet.user.screen_name}:"
  end
when "2"
  client.mentions_timeline.collect do |tweet|
    puts "Identifier par: #{tweet.user.screen_name}"
    puts "#{tweet.text}\n"
  end
when "3"
  client.followers("Mrtintin13").collect do |tweet|
    puts "#{tweet.name}"
    puts "#{tweet.screen_name}\n\n"
  end
when "4"
  puts "Tapez du text:"
  my_tweet = gets
  client.update(my_tweet)
when "5"
  compteur = 1
  client.user_timeline("Mrtintin13").collect do |tweet|
    puts "---------- Tweet n°#{compteur} ----------"
    puts "#{tweet.text} \n\n"
    puts "Écrit le #{tweet.created_at}"
    puts "Retweeté: #{tweet.retweet_count} fois !"
    puts "Aimé: #{tweet.favorite_count} fois !"
    puts "---------- Tweet n°#{compteur} ----------\n\n\n"
    compteur += 1
  end
else
  puts "Au revoir !"
  sleep(1)
end
