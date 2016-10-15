module PagesHelper
  def image_resize(x=100.00, y=100.00, new=50.00)
   x = x * (new/100.00)
   y = y * (new/100.00)
   x.round.to_s + "x" + y.round.to_s
  end

  # TODO seems unnecessary
  def current_page
    @page
  end
end
