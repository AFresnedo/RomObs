# TODO pre-condition
module BlogsHelper
  def get_topics blogs
    topics = []
    blogs.each do |blog|
      topics.append blog.topic unless topics.include?(blog.topic)
    end
    return topics
  end

  def get_authors blogs
    ids = []
    blogs.each do |blog|
      ids.append blog.user_id unless ids.include?(blog.user_id)
    end
    author = []
    ids.each do |id|
      author.append User.find_by_id(id).name
    end
    return author
  end

  def author_name id
    User.find_by_id(id).name
  end

  def get_range_by_date latest, earliest
  end
end
