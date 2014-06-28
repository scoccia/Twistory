require 'twitter'

namespace :twitter_connection do
	
		desc "Connecttion to twitter"

		task twitter_task: :environment do

		client = Twitter::REST::Client.new do |config|
  		config.consumer_key        = "WDBRb1Ag9SupCdXJWSm6VgfxR"
  		config.consumer_secret     = "qjjr3xcJxjtWhFOfziCDroFjnsevSNSam1HgGaVKTMJLGruBt5"
  		config.access_token        = "2593429657-dlGqk5b4UXR4vnfY19PegntbJbCuyqjZZAPEmRA"
  		config.access_token_secret = "GQ9xnJVu7V063LuA1BaMYGxaWJABmtyRfPro3dlQ3az2Z"
		end

		time_now = DateTime.now.to_time
		
		CTRL = Feed.count
		get_feeds = Feed.find(:all)

		i = 0

		while i != CTRL do
	
		ctrl_date = get_feeds[i].date.to_time
		ctrl_sent = get_feeds[i].has_been_published 		

			if ctrl_date < time_now && ctrl_sent == false
				get_text = get_feeds[i].feed_text
				client.update(get_text);
			end		
		i = i+1
		end
	end
end
