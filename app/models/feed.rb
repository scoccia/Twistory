class Feed < ActiveRecord::Base
  validate :checking_feed_text
  validate :checking_for_date
	
  def checking_feed_text
	  if !(feed_text.present?)
      errors[:base] = "Non puoi pubblicare feed vuoti!"
    elsif feed_text.size > 140
      errors[:base] = "Il feed non puo' contenere piu' di 140 caratteri!"
    end
  end 
	
  def checking_for_date
    if !(date.present?) 
      errors[:base] = "E' necessario inserire una data di pubblicazione per il feed!"
    elsif date.utc <= DateTime.now.utc
      errors[:base] = "La data non puo' essere nel passato!"
    end
  end
end
