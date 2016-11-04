class PagesController < ApplicationController
  before_action :admin_user, only: [:about_edit, :contact_edit, :info_edit]

  def welcome
    @page = 'welcome'
    @articles = Article.where(page: @page)
    @mode = 'view'
  end

  def welcome_edit
    @page = 'welcome'
    @articles = Article.where(page: @page)
    @mode = 'edit'
    render 'welcome'
  end

  def about
    @page = 'about'
    @articles = Article.where(page: @page)
    @mode = 'view'
  end

  def about_edit
    @page = 'about'
    @articles = Article.where(page: @page)
    @mode = 'edit'
    render 'about'
  end

  def contact
    @page = 'contact'
    @articles = Article.where(page: @page)
    @mode = 'view'
  end

  def contact_edit
    @page = 'contact'
    @articles = Article.where(page: @page)
    @mode = 'edit'
    render 'contact'
  end

  def info
    @page = 'info'
    @articles = Article.where(page: @page)
    @mode = 'view'
  end

  def info_edit
    @page = 'info'
    @articles = Article.where(page: @page)
    @mode = 'edit'
    render 'info'
  end

end
