module ArticlesHelper
  def to_html body
    body.gsub("\n", '<br>')
  end
end
