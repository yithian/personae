class UserMailer < ActionMailer::Base
  default :from => "no-reply@cityofdarkness.no-ip.org"
  
  def forgot_username(user)
    @user = user
    mail(:to => @user.email_address, :subject => "Forgotten username")
  end

  def forgot_password(user)
    @user = user
    @url = url_for(:controller => "admin", :action => "reset_password", :reset_code => @user.reset_code, :only_path => false)
    mail(:to => @user.email_address, :subject => "Reset password")
  end
end
