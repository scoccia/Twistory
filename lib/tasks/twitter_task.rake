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
			end		
		i = i+1
		end
	end
end
