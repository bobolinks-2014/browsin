class SearchController < ApplicationController

  def search
    # {query=value}
    # {"genres=comedy"}
    # {"i have 30 minutes for comedy"}
    # {"i have 60 minutes for Tom Cruise"}
    # {"Tom Cruise, comedy"}
    # {"20 min, comedy"}

    # /(\d+|\bcomedy|\bTom Cruise)/i

    # tag_key = "search value, like comedy"
    # search_value = "taggable, like genres"
    # Media.tagged_with(["comedy", "30 mins"]).tagged_with()

    movies = Media.tagged_with(tags).tagged_with("show", on: :status, owned_by: current_user)
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
