class SearchController < ApplicationController
  respond_to :json

  def search
    results = Search.find_results(current_user, params[:query])
    matches = results[:matches]
    movies = results[:movies]
    if movies == []
      render json: {success: false, error: params[:query]}
    else
      render json: {media: movies.to_json(include: :actors, methods: [:genre_icons, :service_icons]), matches: matches}
    end
  end

  def top
    if user_signed_in?
      render json: {media: Search.top_list(current_user).to_json(include: :actors, methods: [:genre_icons, :service_icons]), matches: ["top 25 movies based on your available services"]}
    else
      render json: {success: false}
    end
  end

  def find
    render json: {media: Search.find_media(current_user, params[:lookup]).to_json(include: :actors, methods: [:genre_icons, :service_icons]), matches: [params[:lookup]]}
  end

end
