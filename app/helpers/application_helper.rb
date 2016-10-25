module ApplicationHelper
# Returns the full title page on a per-page basis
  def full_title(page_title = '')
    base_title = "Roman's Observatory"
    if page_title.empty?
      base_title #this is an implicit return, courtesy of ruby
    else
      page_title + " | " + base_title
    end
  end
end
