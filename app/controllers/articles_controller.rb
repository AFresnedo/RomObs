class ArticlesController < ApplicationController

  def new
    # send to a new page to enter data with a form with page pre-filled
    # TODO skip this action and instead let "create" happen on-page
    @article = Article.new
  end

  def create
    # create action using form data
    @article = Article.new(article_params)
    # TODO maybe use same macro programming to set page, helper?
    @article.page = 'about'
    if @article.save
      flash[:success] = "Article created."
      # TODO macro program the path using :page
      redirect_to about_path
    else
      # TODO error messages
      flash.now[:danger] = "Couldn't create article."
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
end
