class Feed < ActiveRecord::Base
	validates :feed_text, length: { maximum: 140 }, presence: true
	validate :date_in_the_past
	def date_in_the_past
		if date.utc <= DateTime.now.utc
  			errors.add(:date, "can't be in the past")
  		end
	end
end
