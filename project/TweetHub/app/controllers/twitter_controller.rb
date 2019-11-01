class TwitterController < ApplicationController
  def index
	if !Tweet.first.nil?
		@tweets=Tweet.all 
	else
		mytweet
		redirect_to action: "index"
	end
  end
  private
   def mytweet
	require 'twitter'

	client = Twitter::REST::Client.new do |config|
	  config.consumer_key = "qwSTa4aFJoashomL3gAWFXMTV"
	  config.consumer_secret = "nmBA64tJcZAyc6ejzuMHCFfQDnZMyyQa4K69sUTpKLHLsQQapo"
	  config.access_token = "1188391672406667265-vH15ijJofStsWjxdBOZTtzJUALlqKr"
	  config.access_token_secret = "XAYhr5jHEtdVESeWTQD5x5E7RFFZIbD6mZisY8aLTgDs3"
	end

	timeline = client.user_timeline("freshworksinc")

	timeline.each do |tweet|
	  @tweet=Tweet.new(content: tweet.text ,retweets: tweet.retweet_count)
	  @tweet.save!
	end
   end

end
