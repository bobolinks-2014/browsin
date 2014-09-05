Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/search' => 'home#search', :as => 'search' 
end
