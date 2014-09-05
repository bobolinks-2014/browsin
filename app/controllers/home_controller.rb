class HomeController < ApplicationController
  respond_to :json 

  def search
    movies = Media.tagged_with(tag_key, on: search_value.to_sym).tagged_with("show", on: :status, owned_by: User.first) 
    if movies == []
      respond_with movies, status: 404
    else
      movies.to_json(:include => [{:genres => {only: :name}}, {:services => {only: :name}}, {:platforms => {only: :name}}] )
    end
  end

  private
  
  def search_value
    params.keys[0]
  end
  
  def tag_key
    params.values[0]
  end

end
