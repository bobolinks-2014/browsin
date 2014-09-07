Rails.application.routes.draw do
  post '/users/sign_in' => 'sessions#create'
  delete '/users/sign_out' => 'sessions#destroy'
  post '/users' => 'users#create'
  root 'home#index'
  patch '/media' => 'search#destroy', :as => 'remove'
  get '/search' => 'search#search', :as => 'search' 
end
