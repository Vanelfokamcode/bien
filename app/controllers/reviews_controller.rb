class ReviewsController < ApplicationController

    #be logged in to write a review
    before_action :check_login, except: [:index, :show]


    def index
        # req.params.price came from the url
        @price = params[:price]
        @cuisine = params[:cuisine]
        @location = params[:location]

        @reviews= Review.all

        if @price.present?
            # filter for the price
            @reviews= Review.where(price: @price)
        end
        
        if @cuisine.present?
            # filter for the cuisine
            @reviews= Review.where(cuisine: @cuisine)
        end

        if @location.present?
            #location near by
            @reviews = Review.near(@location)
        end
    end

    def new
      #the form for adding a new review
      @review = Review.new  
    end

    def create

        #take the form info and add it to the model
        @review = Review.new(form_params)

        #and then associate it to a user
        @review.user = @current_user


        #save to the database
        #check if the model can be save if it is go home page
        #if not show new form 
        if @review.save
            #redirect to the home page
            redirect_to root_path
        else
            #show the view.html.erb
            flash.now[:error] = @review.errors.full_messages.join(", ")
            render "new"
        end

    end

    def show
        # individual review page 
        @review = Review.find(params[:id])
    end

    protect_from_forgery with: :exception

    def destroy
        # delete review page 
        @review = Review.find(params[:id])

        # destroy if the are the actual author
        if @review.user == @current_user
            @review.destroy
        end

        # redirect to home page 
        redirect_to root_path
    end

    def edit
        #find review to edit
        @review = Review.find(params[:id])

        # user who don't own a review can't edit nor delete
        if @review.user != @current_user

            redirect_to root_path
            
        elsif @review.created_at < 1.hour.ago
            redirect_to review_path(@review)
        end
    end

    def update
        # find the individual review
        @review = Review.find(params[:id])
        
        if @review.user != @current_user
          redirect_to root_path
        else
          # update with the new info from the form
          if @review.update(form_params)
          
            # redirect somewhere new
            redirect_to review_path(@review)
          else
            render "edit"
          end
          
        end
    end

    def form_params
        params.require(:review).permit(:title, :restaurant, :score, :body, 
            :ambiance, :cuisine, :price, :address, :photo)
    end
end
