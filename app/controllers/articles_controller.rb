class ArticlesController < ApplicationController

  def new
    @article = Article.new(page: params[:page])
  end

  def create
    # create action using form data
    @article = Article.new(article_params)
    if valid_page(params[:article][:page]) && @article.save
      flash[:success] = "Article created."
      # redirect to page where article was posted
      path = send("#{params[:article][:page]}_path")
      redirect_to path
    else
      # TODO error messages from model
      if !valid_page(params[:article][:page])
        flash.now[:danger] = "Invalid page."
      else
        flash.now[:danger] = "Couldn't create article."
      end
      render 'new'
    end
  end

  def edit

  end

  def update
  end

  private

    def article_params
      params.require(:article).permit(:title, :body, :page)
    end

    def valid_page page
      page == 'about' || page == 'contact'
    end
end