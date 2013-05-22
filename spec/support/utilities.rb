include ApplicationHelper

def fulltitle(page_title)
  base_title = "Ruby on Rails (Tutorial) equipo BOB"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end