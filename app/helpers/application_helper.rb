# realize that this helper is borderline bad code, from a design point of view
# it is a product of teaching, not creation
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
