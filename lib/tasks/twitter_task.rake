require 'twitter'

namespace :twitter_connection do
  desc "Connecttion to twitter"

  task twitter_task: :environment do
		
		time_now = DateTime.now.utc
		box = Feed.where("has_been_published = ? and date < ?", '0', :time_now)
		ctrl = box.length
    
    if ctrl > 0
    
		  client = Twitter::REST::Client.new do |config|
  	  	config.consumer_key        = "add your consumer key here"
  	  	config.consumer_secret     = "add your consumer scecret key here"
  	  	config.access_token        = "add your access token here"
  		  config.access_token_secret = "add your access token secret here"
		  end
		  
		  i = 0
    
		  while i != ctrl do
        box[i].update_attribute(:has_been_published, true)
        client.update(box[i].feed_text);
      
			  ## use the line below to debug:                              
			  ## puts "\n\nctrl: #{ctrl}, i: #{i}\ntime now: #{time_now}\nhas_been: #{box[i].has_been_published}\nfeed text: #{box[i].feed_text}"
			  	
				i = i+1
		  end #** while loop finish **#
    end #** if statement finish **#
    
        
	end #*** twitter_task finish ***#
end
