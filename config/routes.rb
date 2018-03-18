Rails.application.routes.draw do
  root to: 'tops#index' 
  resources :sessions, only: [:new, :create, :destroy]
  resources :users 
  resources :blogs do
    
   collection do
      post :confirm
      get :tops
    end    
  end  
end