class Feed < ActiveRecord::Base
	validates :feed_text, length: { maximum: 140 }, presence: true
	validate :date_in_the_past
	def date_in_the_past
		if date.to_time <= DateTime.now.to_time
  			errors.add(:date, "can't be in the past")
  		end
	end
end
