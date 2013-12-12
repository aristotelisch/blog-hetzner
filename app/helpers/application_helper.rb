module ApplicationHelper
  

  # Δημιούργησε τον τιτλο.
  # Αν δεν υπάρχει δυναμικός τιτλος εμφάνισε μόνο τον τιτλο του blog
  # Αν υπάρχει δυναμικός τίτλος εμφάνισε τον τιτλο του blog και τον δυναμικό
  def make_title(page_title)
    default_title = "Happybit.eu Blog"

    if page_title.empty?
      default_title
    else
      default_title + " | " + page_title
    end
  end
end
