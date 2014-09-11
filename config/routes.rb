Rails.application.routes.draw do
  post '/users/sign_in' => 'sessions#create'
  delete '/users/sign_out' => 'sessions#destroy'

  post '/users' => 'users#create'
  get '/users/show' => 'users#show'

  patch '/users' => 'user_service#update'

  patch '/media/add' => 'media_preference#add'
  patch '/media/:id' => 'media_preference#remove', :as => 'remove'

  get '/search' => 'search#search', :as => 'search' 
  get '/top25' => 'search#top'
  get '/find' => 'search#filter'

  get '/users/backdoor' => 'sessions#backdoor' if Rails.env.test?
  
  root 'home#index'
end
