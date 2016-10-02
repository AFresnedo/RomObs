class PagesController < ApplicationController
  def home
  end

  def about
    @articles = Article.where(page: 'about')
  end

  def contact
  end
end
