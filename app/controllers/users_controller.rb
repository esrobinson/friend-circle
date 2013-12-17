class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      login! @user
      redirect_to new_user_url
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
      redirect_to edit_user_url(@user)
      @user.set_password_reset_token!
    else
      flash.now[:notices] = @user.errors.full_messages
      render :edit
    end
  end
end
