Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/search' => 'search#search', :as => 'search' 
end
