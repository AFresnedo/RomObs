class BlogsController < ApplicationController
  before_action :blogger_user, only: [:new, :create]
  before_action :blog_owner, only: [:edit, :update, :destroy]

  def index
    # all blogs, paginated, in order of newest created
    @blogs = Blog.all.paginate(page: params[:page], per_page: 10)
  end

  def show
    @blog = Blog.find_by_id(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Posted successfully."
      redirect_to blogs_path
    else
      render 'new'
    end
  end

  def edit
    @blog = Blog.find_by_id(params[:id])
  end

  def update
    @blog = Blog.find_by_id(params[:id])
    if @blog.update_attributes(blog_params)
      flash[:success] = "Post updated."
      redirect_to blog_path(@blog.id)
    else
      render 'edit'
    end
  end

  def destroy
    Blog.find_by_id(params[:id]).destroy
    flash[:success] = "Post deleted."
    redirect_to blogs_path
  end

  # for getting and displaying results from complex searches (probably on tags)
  def search
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :descript, :body)
    end

    def blogger_user
      redirect_to blogs_path if !current_user or !current_user.blogger?
    end

    def blog_owner
      # all blogs have unique IDs, checking if the user owns this blog
      @blog = current_user.blogs.find_by_id(params[:id])
      redirect_to root_url if @blog.nil?
    end
end
