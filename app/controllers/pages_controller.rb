class PagesController < ApplicationController
  # logged_in_user must be before admin_user to prevent nil.admin? check
  before_action :logged_in_user, only: [:about_edit, :contact_edit]
  before_action :admin_user, only: [:about_edit, :contact_edit]
  def home
    @page = 'home'
    @mode = 'view'
  end

  def home_edit
    @page = 'home'
    @mode = 'edit'
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

end
