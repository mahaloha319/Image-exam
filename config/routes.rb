Rails.application.routes.draw do
  root to: 'tops#index' 
  resources :favorites, only: [:show, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users 
  resources :blogs 
  
  resource :blogs, only: [:favorite] do
    collection do
      post :confirm
      get :favorite
    end    
  end  
end