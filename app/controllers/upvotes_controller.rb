class UpvotesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @upvote = Upvote.new
    @upvote.post = @post
    @upvote.user = current_user
    @post.score += 1
    begin
      Upvote.transaction do
        @upvote.save! && @post.save!
      end
    rescue
      flash[:notices] = @upvote.errors.full_messages || []
      flash[:notices].concat(@post.errors.full_messages)
    end
    redirect_to feed_url
  end

  def destroy
    @upvote = Upvote.find(params[:id])
    @post = @upvote.post
    @post.score -= 1
    begin
      Upvote.transaction do
        @upvote.destroy! && @post.save!
      end
    rescue
      flash[:notices] = @upvote.errors.full_messages || []
      flash[:notices].concat(@post.errors.full_messages)
    end
    redirect_to feed_url
  end


end
