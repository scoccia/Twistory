require 'twitter'

namespace :twitter_connection do
  desc "Connecttion to twitter"

  task twitter_task: :environment do
		
    time_now = DateTime.now.utc
    box = Feed.where("has_been_published = ? and date < ?", '0', :time_now)
    ctrl = box.length
    
    if ctrl > 0
    
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "2kxyua2AU8XimCx70bOPUg"
        config.consumer_secret     = "hZQ5vgQTMeZL9GiXWCaCdAji59CcrkJdsDzw1OYYEZs"
        config.access_token        = "2422291368-f53dCUtUoHOt6ROHaKQ944899wixZvElyp9qv94"
        config.access_token_secret = "OIFnMcailGAl2TcInFqpk8TF1a3cwIPS5goF9zEuaeidw"
      end #those credentials refers to a testing account
		  
      i = 0
    
      while i != ctrl do
      
        box[i].update_attribute(:has_been_published, true)
        
        if !box[i].feed_image.present?
          client.update(box[i].feed_text)
        else
          client.update_with_media(box[i].feed_text, File.new(box[i].feed_image.path))
        end
        ## use the line below to debug:                              
        ## puts "\n\nctrl: #{ctrl}, i: #{i}\ntime now: #{time_now}\nhas_been: #{box[i].has_been_published}\nfeed text: #{box[i].feed_text}"
			  	
        i = i+1
      end #** while loop finish **#
    end #** if statement finish **#
    
        
  end #*** twitter_task finish ***#
end
