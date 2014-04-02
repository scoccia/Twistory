class TwitterOperation

  def send_feed(message_text)
  
  	client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "2kxyua2AU8XimCx70bOPUg"
  config.consumer_secret     = "hZQ5vgQTMeZL9GiXWCaCdAji59CcrkJdsDzw1OYYEZs"
  config.access_token        = "2422291368-f53dCUtUoHOt6ROHaKQ944899wixZvElyp9qv94"
  config.access_token_secret = "OIFnMcailGAl2TcInFqpk8TF1a3cwIPS5goF9zEuaeidw"
 end

  client.update("This is a great app") 
  
  end


end
