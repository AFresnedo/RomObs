class PagesController < ApplicationController
  before_action :logged_in_user, only: :about_edit
  before_action :admin_user, only: :about_edit
  def home
    @page = 'home'
    @mode = 'view'
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
    flash[:success] = @mode
    redirect_to about_url
  end

  def contact
    @page = 'contact'
    @articles = Article.where(page: @page)
    @mode = 'view'
  end

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
