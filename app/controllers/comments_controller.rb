class CommentsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :comment_owner, only: [:update, :destroy]

  def create
    # TODO figure out if possible to get hidden auto-filled fields here
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Posted comment."
      redirect_to blog_path(@comment.blog_id)
    else
      # TODO find a way to redirect to previous blog post, right now @blog nil
      render 'blogs/show'
    end
  end

  def update
    # TODO unsure
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    blog_id = comment.blog_id
    comment.destroy
    flash[:success] = "Comment deleted."
    redirect_to blog_path(blog_id)
  end

  private

    def comment_params
      params.require(:comment).permit(:user_id, :body, :blog_id)
    end

    def comment_owner
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to root_url if @comment.nil?
    end

end
