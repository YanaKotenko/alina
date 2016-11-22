class PostsController < InternalController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.create(user: current_user)
    redirect_to edit_post_path(@post)
  end

  def show
    @content = @post.render
  end

  def edit
  end

  def update
    if @post.update post_params
      head :ok
    else
      head 412
    end
  end

  def destroy
    @post.delete

    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body).merge(user_id: current_user.id)
  end

  def set_post
    @post ||= Post.find(params[:id])
  end
end
