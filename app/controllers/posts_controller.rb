class PostsController < ApplicationController
  before_action :set_chrono

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(chrono: @chrono, content: post_params[:content], picture: post_params[:picture])
    if @post.save
      redirect_to line_path(@chrono.line)
    else
      render :new_post
    end
  end

  private

  def set_chrono
    @chrono = Chrono.find(params[:chrono_id])
  end

  def post_params
    params.require(:post).permit(:content, :picture)
  end
end
