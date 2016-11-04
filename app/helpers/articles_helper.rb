module ArticlesHelper
  def to_html body
    body.gsub("\n", '<br>')
  end

  def gen_id
    ('a'..'z').to_a.shuffle[0..7].join
  end
end
