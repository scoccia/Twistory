class Feed < ActiveRecord::Base

  mount_uploader :feed_image, ImageUploader

  validate :checking_feed_text
  validate :checking_for_date
  validate :checking_for_image_size
 
  private
 
  def checking_for_image_size
    errors[:base] = "L'immagine non può superare 300 Kb" if feed_image.size > 300.kilobytes
  end
	
  def checking_feed_text
    if !(feed_text.present?)
      errors[:base] = "Non puoi pubblicare feed vuoti!"
    elsif feed_image.present? and feed_text.size > 101
      errors[:base] = "Quando inserisci un'immagine il feed non puo' contenere piu' di 101 caratteri!"
    elsif feed_text.size > 124
      errors[:base] = "Il feed non puo' contenere piu' di 124 caratteri!"         
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
