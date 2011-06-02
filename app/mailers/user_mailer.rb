# Functions like a controller, but handles sending mail.
# This "controller" should be edited with the url of the site.

class UserMailer < ActionMailer::Base
  default :from => "no-reply@cityofdarkness.no-ip.org"
  
  # Sends an email to a user's email address with their username.
  def forgot_username(user)
    @user = user
    mail(:to => @user.email_address, :subject => "Forgotten username")
  end

  # Sends an email to a user's email address with a reset code.
  def forgot_password(user, url)
    @user = user
    @url = url
    mail(:to => @user.email_address, :subject => "Reset password")
  end
end
