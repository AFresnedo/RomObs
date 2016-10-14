require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @aboutArticle = articles(:aboutPageArticleOne)
    @new_contact = Article.new(title: "title", body: "body", page: 'contact')
  end

  test "valid contact article is saved" do
    article = @new_contact
    # easier to do article.valid? but here for learning references
    assert_difference 'Article.count', 1 do
      article.save
    end
  end

  test "about page is valid" do
    @new_contact.page = 'whoops'
    assert_not @new_contact.valid?
    @new_contact.page = 'about'
    assert @new_contact.valid?
  end

  test "invalid article is not saved" do
    article = Article.new
    assert_not article.valid?
    # since article is invalid, checking difference is redundant
    assert_difference 'Article.count', 0 do
      article.save
    end
  end

  test "article with an invalid page is invalid" do
    article = @new_contact
    article.page = 'wrong'
    assert_not article.valid?
  end

  test "blank title is invalid" do
    article = @new_contact
    assert article.valid?
    article.title = " " * 10
    assert_not article.valid?
  end

  test "blank body is invalid" do
    article = @new_contact
    assert article.valid?
    article.body = " " * 100
    assert_not article.valid?
  end

end
