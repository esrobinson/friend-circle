class UsersController < ApplicationController
  before_filter :require_logged_in, :only => [:edit, :update, :feed]

  def new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login! @user
      redirect_to feed_url
    else
      flash.now[:notices] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to feed_url
      @user.set_password_reset_token!
    else
      flash.now[:notices] = @user.errors.full_messages
      render :edit
    end
  end

  ORDERS = {'new' => 'created_at', 'best' => 'score'}

  def feed
    order_by = ORDERS[params[:order]] || 'score'


    @posts = current_user.posts
                         .includes(:links)
                         .includes(:author)
                         .includes(:upvoters)
                         .order("#{order_by} DESC")
                         .uniq
    render :feed
  end
end
