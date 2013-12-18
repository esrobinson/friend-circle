class CirclesController < ApplicationController
  before_filter :require_logged_in

  def index
    @user = current_user
    @circles = @user.circles
    render :index
  end

  def new
    @user = current_user
    @members = [current_user]
    @users = User.all
    @circle = Circle.new
    render :new
  end

  def create
    @circle = Circle.new(params[:circle])
    @circle.user = current_user

    flash.now[:notices] = []
    if @circle.save
      redirect_to circle_url(@circle)
    else
      @users = User.all
      @members = @circle.members

      flash.now[:notices].concat(@circle.errors.full_messages)

      @circle.friend_circle_memberships.each do |membership|
        flash.now[:notices].concat(membership.errors.full_messages)
      end

      render :new
    end
  end

  def show
    @circle = Circle.find(params[:id])
    @members = @circle.members
    @posts = current_user.posts
                         .includes(:links)
                         .includes(:author)
                         .order("created_at DESC")
    render :show
  end

  def edit
    @circle = Circle.find(params[:id])
    @users = User.all
    @members = @circle.members
    p @members
    render :edit
  end

  def update
    @circle = Circle.find(params[:id])
    @members = @circle.members
    flash.now[:notices] = []
    if @circle.update_attributes(params[:circle])
      redirect_to circle_url(@circle)
    else
      @users = User.all
      @members = @circle.members

      flash.now[:notices].concat(@circle.errors.full_messages)

      @circle.friend_circle_memberships.each do |membership|
        flash.now[:notices].concat(membership.errors.full_messages)
      end

      render :edit
    end
  end

end
