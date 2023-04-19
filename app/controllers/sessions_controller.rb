class SessionsController < ApplicationController
    
    def new
      # login form
    end

    def create
      # actually try and log in
      @form_data = params.require(:session)    
          
      # pull out the username and password from the form data
      @username = @form_data[:username]
      @password = @form_data[:password]
          
      # lets check the user is who they say they are
      @user = User.find_by(username: @username).try(:authenticate, @password)
  
      # if there is a user present, redirect to home page
      if @user
        #save the user session
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render "new"
      end
    end

    def destroy
        #remove the session after log out
        reset_session

        #redirect to log in page
        redirect_to new_session_path
    end
  
  end