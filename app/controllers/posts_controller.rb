class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5).latest
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else 
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Post was deleted.'
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Post not found"
    redirect_to :action => 'index'
  end
end
