class ApplicationController < ActionController::Base

    #before any pages load run this function

    before_action :find_current_user

    # add method to use in the views
    helper_method :is_logged_in?

    def find_current_user
        if is_logged_in?
            @current_user = User.find(session[:user_id])
        else 
            @current_user = nil
        end 
    end

    #check login status

    def check_login
        unless is_logged_in?
            redirect_to new_session_path
        end 
    end


    def is_logged_in?
        session[:user_id].present? 
    end
end
