require 'twitter'

namespace :twitter_connection do
  desc "Connection to twitter"

  task twitter_task: :environment do
		
    # Remember that the server time is UTC
    time_now = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
    
    box = Feed.where("has_been_published = ? and date < ?", '0', time_now)
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
      
        feed_text = box[i].feed_text
        
	      # Dead code
        # feed_text.gsub(/'/){ "`" }
        # feed_text.gsub(/"/){ "`" }

        # Appending the #LaGrandeGuerra hashtag
        feed_text = feed_text + " #LaGrandeGuerra"
        
        twitter_response = nil

        if !(box[i].feed_image.present?) # Case 1: no pictures are posted #
          
          twitter_response = client.update(feed_text)        
          if !twitter_response.blank? and !twitter_response.id.blank? # Verify that twitter_response is not blank #
	          box[i].update_attribute(:has_been_published, 1)
          else
            box[i].update_attribute(:has_been_published, -1)
            # TODO: trigger an error email to info@ragazzidel99.it
          end
          
        else  # Case 2: pictures are posted #
          
          twitter_response = client.update_with_media(feed_text, File.new(box[i].feed_image.path))

          if !twitter_response.blank? and !twitter_response.id.blank? # Verify that twitter_response is not blank
	          box[i].update_attribute(:has_been_published, 1)
          else
            box[i].update_attribute(:has_been_published, -1)
            # TODO: trigger an error email to info@ragazzidel99.it
          end
         
        end

        # TODO: Use rescue for exception handling in case and error occurs. 
        # For instance, when accidentally sending feeds to Twitter with length greater than 140, 
        # the twitter gem produces a fatal error and exits the task immediately with Twitter::Error::Forbidden: Status is over 140 characters. 


        ## use the line below to debug:                              
        ## puts "\n\nctrl: #{ctrl}, i: #{i}\ntime now: #{time_now}\nhas_been: #{box[i].has_been_published}\nfeed text: #{box[i].feed_text}"
			  	
        i = i+1
      end # end of the "while" loop
    end # end of the "if" statement
    
        
  end # end of twitter_task
end
