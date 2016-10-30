class BlogsController < ApplicationController
  include BlogsHelper
  before_action :blogger_user, only: [:new, :create]
  before_action :blog_owner, only: [:edit, :update, :destroy]

  def index
    # TODO seperate filter, preceeding all, that sets time frame

    if !params[:topic].nil? && !params[:author].nil?
      blogs = Blog.where(topic: params[:topic], user_id: params[:author])
    elsif !params[:topic].nil?
      blogs = Blog.where(topic: params[:topic])
    elsif !params[:author].nil?
      blogs = Blog.where(user_id: params[:author])
    else
      blogs = Blog.all
    end
    @blogs = blogs.paginate(page: params[:page], per_page: 10)
    @topics = get_topics(blogs)
    @authors = get_authors(blogs)
  end

  def show
    @blog = Blog.find_by_id(params[:id])
    # show all comments for this blog, paginated, in order of newest created
    @comments = @blog.comments.paginate(page: params[:page], per_page: 5)
    # form for creating new comment
    # TODO remove visibility for blog_id and user_id
    @comment = Comment.new(blog_id: @blog.id, user_id: current_user.id)
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
