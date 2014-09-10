Rails.application.routes.draw do
  resources :users, only: [:show, :create, :update] do
    collection do
      post :sign_in, controller: 'sessions', action: 'create'
      delete :sign_out, controller: 'sessions', action: 'destroy'
      get :backdoor => 'sessions#backdoor' if Rails.env.test?
    end
    member do
      patch :add
    end
  end

  patch '/media/:id' => 'users#remove', :as => 'remove'
  get '/search' => 'search#search', :as => 'search' 
  get '/top25' => 'search#top'
  get '/find' => 'search#find'
  root 'home#index'
end