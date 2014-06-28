namespace :test_namespace do
	desc "Simple test"
	task test_task: :environment do

		time_now = DateTime.now.to_time
		
		CTRL = Feed.count
		ctrl_id = Feed.find(:all)

		i = 0

		while i != CTRL do

		x = ctrl_id[i].id		
		
		get_feed = Feed.find_by_id(x)
		ctrl_date = get_feed.date.to_time
		ctrl_sent = get_feed.has_been_published
	
		puts "\t   id: #{x}\tsent?: #{ctrl_sent}"
		puts "\t date: #{ctrl_date}"
		puts "\t  now: #{time_now}"
		
			if ctrl_date < time_now && ctrl_sent == false
				# add the code to post on twitter
				puts "ready to send"
			else
				puts "not ready"
			end
		i = i+1

		end
	end
end
