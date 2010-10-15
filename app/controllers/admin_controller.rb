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
 
  def forgot_password
    if request.post?
      user = User.find_by_name(params[:username])
      user.generate_reset_code
      @url = url_for(:action => "reset_password", :reset_code => user.reset_code)
      UserMailer.forgot_password(user).deliver

      flash[:notice] = "Password reset link sent to your email address"
    end
  end

  def reset_password
    @reset_code = params[:reset_code]
    @user = User.find_by_reset_code(@reset_code)

    if request.post?
      flash[:notice] = "Successfully changed password" if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      @user.clear_reset_code

      redirect_to :action => "login"
    end
  end
end
