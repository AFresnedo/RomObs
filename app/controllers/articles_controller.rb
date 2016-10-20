class ArticlesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def new
    # TODO autofill page from about/contact/home
    @article = Article.new(page: params[:page])
  end

  def create
    # create action using form data
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article created."
      # redirect to page where article was posted
      redirect_to path
    else
      # model error messages displayed by view here
      render 'new'
    end
  end

  def edit
    @article = Article.find_by_id(params[:id])
  end

  def update
    # target appropriate article
    @article = Article.find_by_id(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Article updated."
      redirect_to path
    else
      render 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    page = article.page
    article.destroy
    flash[:success] = "Article deleted."
    redirect_to send("#{page}_path")
  end

  private

    def article_params
      params.require(:article).permit(:title, :body, :page)
    end

    # some meta programming to say "page_path" where page depends on article
    def path
      send("#{@article.page}_path")
    end

end
