class CommentsController < ApplicationController
    def create
        # find the review to be comment on
        @review = Review.find(params[:review_id])
        
        @comment = Review.comments.new(params.require(:comment).permit(:body))

        @comment.save

        #go back to the review show page 
        #(individual review page which is being commented)
        
        redirect_to review_path(@review)

    end
end
