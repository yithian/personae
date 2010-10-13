class UserMailer < ActionMailer::Base
  default :from => "no-reply@cityofdarkness.no-ip.org"
  
  def forgot_username(user)
    @user = user
    mail(:to => @user.email_address, :subject => "Forgotten username")
  end

  def forgot_password(user)
    @user = user
    mail(:to => @user.email_address, :subject => "Reset password")
  end
end
