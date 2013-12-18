class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                      params[:user][:password])
    if @user
      login!(@user)
      redirect_to feed_url
    else
      flash.now[:notices] = ["Invalid email/password"]
      render :new
    end
  end

  def destroy
    logout!(current_user)
    redirect_to new_session_url
  end

  def forgot_password
    render :forgot_password
  end

  def mail_password
    user = User.find_by_email(params[:user][:email])
    user.set_password_reset_token!

    msg = UserMailer.password_email(user.email, user.password_reset_token)
    msg.deliver!

    redirect_to new_session_url
  end

  def reset_password
    @user = User.find_by_password_reset_token(params[:token])

    login! @user

    redirect_to edit_user_url(@user)
  end
end
