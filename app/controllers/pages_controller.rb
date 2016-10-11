class PagesController < ApplicationController
  def home
    @page = 'home'
  end

  def about
    @page = 'about'
    @articles = Article.where(page: @page)
  end

  def contact
    @page = 'contact'
    @articles = Article.where(page: @page)
  end
end
