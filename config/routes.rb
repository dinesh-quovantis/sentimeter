Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => 'home#index'

  get 'static_dashboard' => 'sentiments#static_dashboard'
  
  get 'dashboard' => 'sentiments#dashboard'

  get 'get_tweets' => 'sentiments#get_tweets'
  
  get 'get_selected_tweets' => 'sentiments#get_selected_tweets'

  get 'comparison' => 'sentiments#comparison'

  get 'home' => 'home#index'
  
  resources :tweets do 
  	collection do 
      post :start_progress
  	end
    member do
      get :timeline
      get :mark_closed
      post :comment
      get :view_progress
    end  
  end
  
  get "/auth/:provider/callback" => "sessions#create"
  
  delete "/signout" => "sessions#destroy", :as => :signout
end
