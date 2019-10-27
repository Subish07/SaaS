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
	  config.consumer_key = "YOUR_CONSUMER_KEY"
	  config.consumer_secret = "YOUR_CONSUMER_SECRET"
	  config.access_token = "YOUR_ACCESS_TOKEN"
	  config.access_token_secret = "YOUR_ACCESS_SECRET"
	end

	timeline = client.user_timeline("freshworksinc")

	timeline.each do |tweet|
	  @tweet=Tweet.new(content: tweet.text ,retweets: tweet.retweet_count)
	  @tweet.save!
	end
   end

end
