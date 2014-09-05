class SearchController < ApplicationController

  def search
    movies = Media.tagged_with(tag_key, on: search_value.to_sym).tagged_with("show", on: :status, owned_by: current_user) 
    if movies == []
      respond_with movies, status: 404
    else
      render json: movies, include: [:genres, :services, :platforms]
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
