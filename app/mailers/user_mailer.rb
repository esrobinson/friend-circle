class UserMailer < ActionMailer::Base
  default from: "passwords@example.com"


  def password_email(email, token)
    @token = token
    @email = email

    mail(:to => email, :subject => "Forgot your password?")
  end
end
