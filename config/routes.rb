Rails.application.routes.draw do
  resources :reviews do 
    resources :comments
    #user only put one bookmark on a review
    resource :bookmark
  end
  
  resources :users

  # one session at the time login or logout (not login twice nor logout)
  resource :session

  
  root "reviews#index"
end
