class UsersController < ApplicationController

    def index
        @users = User.all
    end

    
    def new
        @user = User.new
    end

    def create
        #take the user info from "form_params" 
        #and fill in for creating a new user
        #create a new user
        @user = User.new(form_params)

        #if it is valid and save, go to users list page
        #if not see the form with errors

        if @user.save
            session[:user_id] = @user.id
            redirect_to users_path
        else
            render "new"
        end




    end

    def form_params
        params.require(:user).permit(:username, :email, :password, 
        :password_confirm  )
    end
end
