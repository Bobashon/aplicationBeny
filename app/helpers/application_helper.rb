module ApplicationHelper
  def fulltitle(sampletitle)
    base_title = "Ruby on Rails (Tutorial) equipo BOB"
    if sampletitle.to_s.empty?
      return base_title
    else
      return "#{base_title} | #{sampletitle}"
    end
  end
end
