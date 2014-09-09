Rails.application.routes.draw do
  post '/users/sign_in' => 'sessions#create'
  delete '/users/sign_out' => 'sessions#destroy'
  post '/users' => 'users#create'
  root 'home#index'
  patch '/media/:id' => 'search#remove', :as => 'remove'
  get '/search' => 'search#search', :as => 'search' 
  get '/top25' => 'search#top'
  get '/find' => 'search#find'

  get '/users/backdoor' => 'sessions#backdoor' if Rails.env.test?
end
