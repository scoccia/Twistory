class Feed < ActiveRecord::Base
	validates :feed_text, length: { maximum: 140 }, presence: true
	validate :checking_for_date
	def checking_for_date
		if  !(date.present?) 
  			errors.add(:date, "can't be blank")
  		elsif date.utc <= DateTime.now.utc
  			errors.add(:date, "can't be in the past")
  		end
	end
end
