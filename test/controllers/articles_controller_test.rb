require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @basic = users(:basic)
    @admin = users(:admin)
    @contactArticle = articles(:contactArticle)
  end

  test "basic and logged out users cannot view article create page" do
    # log in as basic user with password and remember flag on
    log_in_as(@basic, 'basic', '1')
    get new_article_path
    assert_response :redirect, root_url
    # log out
    log_out_fixture
    get new_article_path
    assert_response :redirect, root_url
  end

  test "admin can view article create page" do
    # log in as admin with password and remember flag on
    log_in_as(@admin, 'admin', '1')
    get new_article_path
    assert_response :success
  end

  test "basic and logged out users cannot create articles" do
    log_in_as(@basic, 'basic', '1')
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: 'title',
                                              body: 'body',
                                              page: 'about' } }
    end
    log_out_fixture
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: 'title',
                                              body: 'body',
                                              page: 'about' } }
    end
  end

  test "admin users can create articles" do
    log_in_as(@admin, 'admin', '1')
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'title',
                                              body: 'body',
                                              page: 'about' } }
    end
  end

  test "basic and logged out users cannot view article edit page" do
    log_in_as(@basic, 'basic', '1')
    # don't know IDs of fixtures, so just get the first
    article = Article.first
    get edit_article_path(article.id)
    assert_redirected_to root_url
    log_out_fixture
    get edit_article_path(1)
    assert_redirected_to login_url
  end

  test "admin user can view article edit page" do
    log_in_as(@admin, 'admin', '1')
    article = Article.first
    get edit_article_path(article.id)
    assert_response :success
    assert_template 'articles/edit'

  end

  test "admin user can update article" do
    log_in_as(@admin, 'admin', '1')
    # article = @contactArticle
    # post articles_path, params: { article: { title: 'old title',
                                            # body: article.body,
                                            # page: article.page } }
    article = Article.last
    patch article_path(article.id), params: { article: { title: 'updated title',
                                                         body: article.body,
                                                         page: article.page } }
    path = send("#{article.page}_path")
    assert_redirected_to path
    follow_redirect!
    assert_template "pages/#{article.page}"
    assert_select 'h3', 'updated title'
  end

end
