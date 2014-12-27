module ApplicationHelper
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      require 'pygments'
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: false)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
  # Δημιούργησε τον τιτλο.
  # Αν δεν υπάρχει δυναμικός τιτλος εμφάνισε μόνο τον τιτλο του blog
  # Αν υπάρχει δυναμικός τίτλος εμφάνισε τον τιτλο του blog και τον δυναμικό
  def title(page_title)
    default_title = "Happybit.eu Blog"

    if page_title.empty?
      title = default_title
    else
      title = page_title.to_s + " | " + default_title
    end

    content_for :page_title, title
  end
end
