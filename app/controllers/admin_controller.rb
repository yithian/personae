class AdminController < ApplicationController  
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || { :controller => :characters, :action => :index })
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = :logged_out
    flash[:notice] = "Logged out"
    
    redirect_to :controller => :admin, :action => :login
  end
  
  def forgot_username
    if request.post?
      user = User.find_by_email_address(params[:email_address])
      UserMailer.forgot_username(user).deliver
      
      flash[:notice] = "Username has been sent to #{params[:email_address]}"
      redirect_to :action => "login"
    end
  end
end
