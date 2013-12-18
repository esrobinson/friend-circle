class PostsController < ApplicationController
  before_filter :require_logged_in


  def new
    @circles = current_user.circles
    render :new
  end

  def create
    @post = Post.new(params[:post])
    @post.author = current_user
    links = params[:links].values.reject{ |value| value["url"].empty? }
    @post.links.new(links)
    if @post.save
      redirect_to feed_url
    else
      flash.now[:notices] = []
      flash.now[:notices].concat(@post.errors.full_messages)
      @post.links.each do |link|
        flash.now[:notices].concat(link.errors.full_messages)
      end
      @circles = current_user.circles
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to feed_url
  end

end
