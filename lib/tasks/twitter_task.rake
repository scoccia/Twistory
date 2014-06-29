require 'twitter'

namespace :twitter_connection do
	
		desc "Connecttion to twitter"

		task twitter_task: :environment do

		client = Twitter::REST::Client.new do |config|
  		config.consumer_key        = "add your consumer key here"
  		config.consumer_secret     = "add your consumer scecret key here"
  		config.access_token        = "add your access token here"
  		config.access_token_secret = "add your access token secret here"
		end

		time_now = DateTime.now.utc
		
		CTRL = Feed.count
		feed_box = Feed.find(:all)

		i = 0

		while i != CTRL do
	
		ctrl_date = feed_box[i].date
		ctrl_sent = feed_box[i].has_been_published 		

			if ctrl_sent == false && ctrl_date < time_now
				get_text = feed_box[i].feed_text
				feed_box[i].update_attribute(:has_been_published, true)
				client.update(get_text);
				# use this for debug: 
				# puts "time now: #{time_now}  date: #{ctrl_date}"
			end		
		i = i+1
		end
	end
end
