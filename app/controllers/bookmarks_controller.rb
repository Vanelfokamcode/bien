class BookmarksController < ApplicationController

    before_action :check_login

    
    def create
        #find review to bookmarking
        @review = Review.find(params[:review_id])

        @bookmark = Review.bookmark.new

        #associate bookmark to a user
        @bookmark.user = @current_user

        @bookmark.save  

        #redirect to the actual review being bookmark so (@review)

        redirect_to review_path(@review)
    end


    def destroy
        @review = Review.find(params[:review_id])
        
        @review.bookmarks.where(user: @current_user).delete_all
        
        redirect_to review_path(@review)
      end




end
